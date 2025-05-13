variable "project_id" {
  description = "GCP project ID to deploy resources into"
  type        = string
}

variable "region" {
  description = "GCP region to use"
  type        = string
  default     = "us-central1"
  validation {
    condition     = contains(["us-central1", "us-east1", "us-west1"], var.region)
    error_message = "Region must be one of: us-central1, us-east1, us-west1"
  }
}

variable "db_password" {
  description = "Root password for the MySQL Cloud SQL instance"
  type        = string
  sensitive   = true
}
