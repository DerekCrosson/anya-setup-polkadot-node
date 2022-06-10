module "networking" {
  source = "./modules/networking"
}

module "security" {
  source = "./modules/security"

  vpc_id = module.networking.vpc_id
}
