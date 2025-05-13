resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = var.network_self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_range.name]
  depends_on              = [google_compute_global_address.private_ip_range]
}

resource "google_compute_global_address" "private_ip_range" {
  name          = "google-managed-services-gallery"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.network_self_link
}

resource "google_sql_database_instance" "mysql" {
  name             = "gallery-db"
  region           = var.region
  database_version = "MYSQL_8_0"

  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier = "db-n1-standard-1"
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.network_self_link
    }
  }

  root_password = var.db_password
}

resource "google_sql_database" "photo_gallery" {
  name     = "photo_gallery"
  instance = google_sql_database_instance.mysql.name
}
