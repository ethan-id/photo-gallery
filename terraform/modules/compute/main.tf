resource "google_compute_instance" "vm" {
  name         = "gallery-vm"
  machine_type = "e2-standard-2"
  zone         = "${var.region}-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network       = var.network_self_link
    subnetwork    = var.subnetwork_self_link
    access_config {}  # Enables external IP
  }

  metadata_startup_script = file("${path.module}/../../scripts/startup.sh")

  tags = ["http-server"]
}
