variable "region" {
  description = "Region to deploy the Cloud SQL instance"
  type        = string
}

variable "network_self_link" {
  description = "VPC network to attach the SQL instance to"
  type        = string
}

variable "db_password" {
  description = "Root password for the MySQL instance"
  type        = string
  sensitive   = true
}
