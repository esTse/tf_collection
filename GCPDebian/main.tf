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

resource "google_compute_firewall" "custom_rules" {
  name    = "allow-custom-port"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = [var.allowed_port]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["custom-server"]
}

resource "google_compute_instance" "vm_instance" {
  name         = "debian-node-server"
  machine_type = var.machine_type
  tags         = ["custom-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = var.disk_size
    }
  }

  network_interface {
    network = "default"
    access_config {
      # Ephemeral public IP
    }
  }

  metadata_startup_script = file("${path.module}/startup.sh")

  service_account {
    scopes = ["cloud-platform"]
  }
}

output "instance_ip" {
  value = "Instance public IP: ${google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip}"
}

output "ssh_command" {
  value = "Instance deployed. You can access it by: gcloud compute ssh --zone ${var.zone} ${google_compute_instance.vm_instance.name} --project ${var.project_id}"
}
