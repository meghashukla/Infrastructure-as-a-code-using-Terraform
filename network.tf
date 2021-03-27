module "vpc" {
  source = "./modules/vpc"

  vpc_region     = var.vpc_region
  vpc_name       = var.vpc_name
  vpc_cidr_block = var.vpc_cidr_block
}

module "subnet_public" {
  source = "./modules/sn-public"

  vpc_id      = module.vpc.id
  vpc_region  = module.vpc.region
  subnet_name = var.subnet_public
  subnet_cidr = var.subnet_public_cidr
  subnet_az   = var.subnet_public_az
}

module "subnet_private" {
  source = "./modules/sn-private"

  vpc_id      = module.vpc.id
  vpc_region  = module.vpc.region
  subnet_cidr = var.subnet_private_cidr
  subnet_name = var.subnet_private
  subnet_az   = var.subnet_private_az
  publicsubnet = element(module.subnet_public.id,2)
}