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
  description = "The machine type for the instance"
  type        = string
  default     = "e2-medium"
}

variable "disk_size" {
  description = "The size of the boot disk in GB"
  type        = number
  default     = 20
}

variable "allowed_port" {
  description = "The port to open in the firewall"
  type        = number
  default     = 1808
}
