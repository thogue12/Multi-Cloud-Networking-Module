locals {
  region      = "us-east-1"
  envrionment = "Test"
  Project     = "Smooth"
  global_name = "${var.name}-${local.envrionment}-${local.Project}"
  tags = {
    Envrionment = local.envrionment
    Project     = local.Project
  }

}

module "vpc" {
  source               = "../../Modules/vpc"
  name                 = "Smooth"
  vpc_cidr             = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = local.tags
}

module "subnets" {
  source                        = "../../Modules/subnets"
  create_pub_subs               = true
  name                          = "Smooth"
  create_private_subnets        = true
  public_subnets_cidr_blocks    = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets_cidr_blocks   = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24", "10.0.7.0/24"]
  availability_zones            = ["us-east-1a", "us-east-1b", "us-east-1c"]
  map_public_ip_on_launch       = true
  map_public_ip_on_private_subs = false
  vpc_id                        = module.vpc.vpc_id
  tags                          = local.tags

}

module "route-tables" {
  source                      = "../../Modules/route-tables"
  vpc_id                      = module.vpc.vpc_id
  public_subnets              = module.subnets.public_subnets
  private_subnets             = module.subnets.private_subnets
  tags                        = local.tags
  create_public_subnets       = module.subnets.create_public_subnets
  create_private_subnets      = module.subnets.create_private_subnets
  public_subnets_cidr_blocks  = module.subnets.public_subnets_cidr_blocks
  private_subnets_cidr_blocks = module.subnets.private_subnets_cidr_blocks
  nat_id                      = module.igw-nat.nat_id
  igw_id                      = module.igw-nat.igw_id
  name                        = "Smooth"
}

module "igw-nat" {
  source                      = "../../Modules/igw-nat"
  vpc_id                      = module.vpc.vpc_id
  public_subnets              = module.subnets.public_subnets
  tags                        = local.tags
  public_subnets_cidr_blocks  = module.subnets.public_subnets_cidr_blocks
  private_subnets_cidr_blocks = module.subnets.private_subnets_cidr_blocks
  private_subnets             = module.subnets.private_subnets
  name                        = "Smooth"

}