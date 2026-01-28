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

resource "google_compute_firewall" "n8n_rules" {
  name    = "n8n-allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = [var.n8n_port]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["n8n-server"]
}

resource "google_compute_instance" "n8n_instance" {
  name         = "n8n-server"
  machine_type = var.machine_type
  tags         = ["n8n-server"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = var.disk_size
    }
  }

  network_interface {
    network = "default"
    access_config {
      # Ephemeral public IP
    }
  }

  metadata_startup_script = templatefile("${path.module}/startup.sh", {
    n8n_key         = var.n8n_encryption_key
    n8n_port        = var.n8n_port
    n8n_docker_image = var.n8n_docker_image
  })

  service_account {
    scopes = ["cloud-platform"]
  }
}
