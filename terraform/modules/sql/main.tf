resource "google_sql_database_instance" "mysql" {
  name             = "gallery-db"
  region           = var.region
  database_version = "MYSQL_8_0"

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
