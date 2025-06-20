
locals {
  region = "us-east-1"
}

module "vpc" {
  source                        = "../../Modules/vpc"
  create_vpc                    = "true"
  vpc_cidr                      = "10.0.0.0/16"
  enable_dns_hostnames          = "true"
  enable_dns_support            = "true"
  public_subnets_cidr_blocks    = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  private_subnets_cidr_blocks   = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
  availability_zones            = ["us-east-1a", "us-east-1b", "us-east-1c"]
  map_public_ip_on_launch       = "true"
  map_public_ip_on_private_subs = "false"
  create_nat                    = "true"
  name                          = "smooth"
  create_igw                    = "true"
  tags = {
    Environment = "Dev"
    Project     = "Smooth"
  }
 
}