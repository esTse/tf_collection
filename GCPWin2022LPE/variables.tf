variable "project_id" {
  description = "The ID of your Google Cloud project"
  type        = string
}

variable "region" {
  description = "The region where the VM will live"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The specific zone"
  type        = string
  default     = "us-central1-a"
}

variable "vm_name" {
  description = "The name of the Virtual Machine"
  type        = string
  default     = "windows-11-pro-gemini"
}

variable "machine_type" {
  description = "Machine type (power)"
  type        = string
  default     = "e2-standard-8" # 8 vCPUs, 32GB RAM
}

variable "admin_user" {
  description = "Administrator username"
  type        = string
  default     = "Administrator"
}

variable "admin_password" {
  description = "Administrator password"
  type        = string
  sensitive   = true
}

variable "attacker_user" {
  description = "Non-privileged username"
  type        = string
  default     = "attacker"
}

variable "attacker_password" {
  description = "Non-privileged user password"
  type        = string
  sensitive   = true
}
