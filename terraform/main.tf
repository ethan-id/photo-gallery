provider "google" {
  project = var.project_id
  region  = var.region
}

module "network" {
  source = "./modules/network"
  region = var.region
}

module "sql" {
  source             = "./modules/sql"
  region             = var.region
  db_password        = var.db_password
  network_self_link  = module.network.network_self_link
}

module "compute" {
  source            = "./modules/compute"
  region            = var.region
  network_self_link = module.network.network_self_link
}
