module "networking" {
  source = "./modules/networking"
}

# module "security" {
#   source = "./modules/security"

#   vpc_id = module.networking.vpc_id
# }

module "machines" {
  source = "./modules/machines"

  subnet_id = module.networking.subnet_id
  #vpc_security_group_ids = [module.security.security_group_id]
}
