output "vm_external_ip" {
  description = "Public IP address of the VM running the photo gallery"
  value       = module.compute.vm_ip
}

output "db_connection_name" {
  description = "Cloud SQL connection string"
  value       = module.sql.db_connection_name
}
