module "compute" {
  source               = "./modules/compute"
  region               = var.region
  network_self_link    = module.network.network_self_link
  subnetwork_self_link = module.network.subnetwork_self_link
}
