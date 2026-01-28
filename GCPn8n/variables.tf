variable "project_id" {
  description = "The GCP Project ID"
  type        = string
}

variable "region" {
  description = "The GCP region to deploy to"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The GCP zone to deploy to"
  type        = string
  default     = "us-central1-a"
}

variable "machine_type" {
  description = "The machine type for the n8n instance"
  type        = string
  default     = "e2-medium"
}

variable "disk_size" {
  description = "The size of the boot disk in GB"
  type        = number
  default     = 50
}

variable "n8n_port" {
  description = "The port to run n8n on"
  type        = number
  default     = 5678
}

variable "n8n_docker_image" {
  description = "The Docker image for n8n"
  type        = string
  default     = "docker.n8n.io/n8nio/n8n"
}

variable "n8n_encryption_key" {
  description = "The encryption key for n8n credentials (keep this safe and consistent)"
  type        = string
  sensitive   = true
}

variable "n8n_domain" {
  description = "Domain name for n8n (optional, for SSL generation via Traefik if needed, but keeping it simple for now)"
  type        = string
  default     = ""
}
