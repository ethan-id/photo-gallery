output "db_private_ip" {
  value = google_sql_database_instance.mysql.private_ip_address
}

output "db_connection_name" {
  value = google_sql_database_instance.mysql.connection_name
}
