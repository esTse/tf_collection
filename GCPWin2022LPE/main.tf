terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# --- 1. AUTOMATIC API ACTIVATION ---
# Enables Compute Engine API
resource "google_project_service" "compute_api" {
  service            = "compute.googleapis.com"
  disable_on_destroy = false # Do not disable the API when destroying the VM (safety first)
}

# --- 2. VIRTUAL MACHINE ---
resource "google_compute_instance" "vm_windows" {
  # Note: depends_on tells Terraform: "Don't create this until the API is active"
  depends_on = [google_project_service.compute_api]

  name         = var.vm_name
  machine_type = var.machine_type

  # Disk
  boot_disk {
    initialize_params {
      image = "windows-server-2025-dc-v20260114"
      size  = 100      # Increased to 100GB as Windows grows fast
      type  = "pd-ssd" # SSD mandatory for speed
    }
  }

  # Network
  network_interface {
    network = "default"
    access_config {
      # Ephemeral Public IP
    }
  }

  # Windows Security
  shielded_instance_config {
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }

  # Installation Script (Chocolatey + Python + Gemini Lib)
  metadata = {
    sysprep-specialize-script-ps1 = <<EOF
      # 1. Install Chocolatey (Package Manager)
      Set-ExecutionPolicy Bypass -Scope Process -Force; 
      [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; 
      iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
      
      # Refresh environment to use choco immediately
      $env:Path = $env:Path + ";$env:ALLUSERSPROFILE\chocolatey\bin"

      # 2. Install basic tools
      choco install python -y
      choco install git -y
      choco install vscode -y 

      # 3. Create non-privileged attacker user
      # First disable password complexity requirements to allow simple passwords
      secedit /export /cfg c:\secpol.cfg
      (gc C:\secpol.cfg).replace("PasswordComplexity = 1", "PasswordComplexity = 0") | Out-File C:\secpol.cfg
      secedit /configure /db c:\windows\security\local.sdb /cfg c:\secpol.cfg /areas SECURITYPOLICY
      rm -force c:\secpol.cfg -confirm:$false

      net user ${var.attacker_user} "${var.attacker_password}" /add /Y
      # Add to Remote Desktop Users group to allow RDP connection
      net localgroup "Remote Desktop Users" ${var.attacker_user} /add

      # 5. Set Administrator password
      net user ${var.admin_user} "${var.admin_password}" /active:yes
      # Ensure administrator is also in the correct group (though it has access by default)
      net localgroup "Remote Desktop Users" ${var.admin_user} /add
    EOF
  }
}

# --- 3. OUTPUT ---
output "vm_name" {
  description = "Name of the created Virtual Machine"
  value       = google_compute_instance.vm_windows.name
}

output "public_ip" {
  description = "Public IP for RDP connection"
  value       = google_compute_instance.vm_windows.network_interface.0.access_config.0.nat_ip
}

output "created_users" {
  description = "Users available for RDP connection (user:password)"
  value = [
    "${var.admin_user}:${nonsensitive(var.admin_password)}",
    "${var.attacker_user}:${nonsensitive(var.attacker_password)}"
  ]
}
