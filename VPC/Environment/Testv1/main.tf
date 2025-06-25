locals {
  region      = "us-east-1"
  region_2    = "us-east-2"
  envrionment = "Test"
  Project     = "Smooth"
  global_name = "${var.name}-${local.Project}-${local.envrionment}"
  tags = {
    Envrionment = local.envrionment
    Project     = local.Project
  }

}
####################################################################
# VPC
####################################################################
module "vpc" {
  source = "../../Modules/vpc"
  name   = local.global_name

  vpc_attributes = {
    vpc = {
      cidr_block           = "10.0.0.0/16"
      enable_dns_support   = true
      enable_dns_hostnames = true
      region               = local.region
    }
    vpc_2 = {
      cidr_block           = "10.10.0.0/16"
      enable_dns_support   = false
      enable_dns_hostnames = false
      region               = local.region_2
    }
  }
  tags = local.tags
}

####################################################################
# Subnets
####################################################################
module "subnets" {
  source = "../../Modules/subnets"
  name   = local.global_name
  public_subnets = {
    pub_subnet_1 = {
      vpc_id                  = module.vpc.vpc_id["vpc"]
      cidr_block              = ["10.0.0.0/24"]
      availability_zone       = ["us-east-1a"]
      map_public_ip_on_launch = true
    }

    pub_subnet_2 = {
      vpc_id                  = module.vpc.vpc_id["vpc"]
      cidr_block              = ["10.0.1.0/24"]
      availability_zone       = ["us-east-1b"]
      map_public_ip_on_launch = true
    }
  }
  private_subnets = {
    priv_subnet_1 = {
      vpc_id                  = module.vpc.vpc_id["vpc"]
      cidr_block              = ["10.0.2.0/24"]
      availability_zone       = ["us-east-1a"]
      map_public_ip_on_launch = false
    }
    priv_subnet_2 = {
      vpc_id                  = module.vpc.vpc_id["vpc"]
      cidr_block              = ["10.0.3.0/24"]
      availability_zone       = ["us-east-1b"]
      map_public_ip_on_launch = false
    }
  }
}
####################################################################
# Route Tables
####################################################################

module "route-tables" {
  source = "../../Modules/route-tables"
  name   = local.global_name
  tags   = local.tags
  public_route_tables = {
    public_rt1 = {
      vpc_id = module.vpc.vpc_id["vpc"]
      region = local.region
    }
  }

  public_routes = {
    public_routes = {
      type                   = "public"
      route_table_id         = module.route-tables.public_route_table_id["public_rt1"]
      destination_cidr_block = "0.0.0.0/0"
      gateway_id             = module.igw-nat.igw_id["igw"]
    }
  }
  public_route_table_associations = {
    pub_rt1_subnet1 = {                        # unique key
      route_table_id = module.route-tables.public_route_table_id["public_rt1"]
      subnet_id      = module.subnets.public_subnets["pub_subnet_1"]
  }
  pub_rt1_subnet2 = {
    route_table_id = module.route-tables.public_route_table_id["public_rt1"]
    subnet_id      = module.subnets.public_subnets["pub_subnet_2"]
  }
      
    }
   # Accessing the first public subnet

  private_route_tables = {
    private_rt1 = {
      vpc_id = module.vpc.vpc_id["vpc"]
      region = local.region
    }
  }
  private_routes = {
    private_route = {
      type                   = "private"
      route_table_id         = module.route-tables.private_route_table_id["private_rt1"] # Syntax = module<nameof module><output var><[keyname]>
      destination_cidr_block = "0.0.0.0/0"
      nat_gateway_id         = module.igw-nat.nat_id["main_nat"]
    }
  }

  private_route_table_associations = {
    priv_rt1_subnet1 = {                        # unique key
      route_table_id = module.route-tables.private_route_table_id["private_rt1"]
      subnet_id      = module.subnets.private_subnets["priv_subnet_1"]
  }
  priv_rt1_subnet2 = {
    route_table_id = module.route-tables.private_route_table_id["private_rt1"]
    subnet_id      = module.subnets.private_subnets["priv_subnet_2"]
  }
}
}




####################################################################
# Internet Gateway and NAT Gateway
####################################################################
module "igw-nat" {
  source = "../../Modules/igw-nat"
  eip = {
    main_eip = {
      region = local.region
      tags   = local.tags
    }
  }

  nat_gateway = {
    main_nat = {
      allocation_id = module.igw-nat.allocation_id["main_eip"]
      subnet_id     = module.subnets.public_subnets["pub_subnet_1"] # no need to add .id because it is already a string and established in the outputs
    }
  }

  internet_gateway = {
    igw = {
      vpc_id = module.vpc.vpc_id["vpc"]
      tags   = local.tags
    }
  }
  name = local.global_name
}




####################################################################
# Security Groups
####################################################################
module "security-groups" {
  source = "../../Modules/security-groups"
  vpc_id = module.vpc.vpc_id["vpc"]
  name   = local.global_name
  tags   = local.tags

  security_group_description = "Security group for Smooth project"

  ingress_rules = [

    {
      type        = "ingress"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Allow SSH access"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      type        = "ingress"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "Allow HTTP access"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      type        = "ingress"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "Allow HTTPS access"
      cidr_blocks = ["0.0.0.0/0"]
    }

  ]

}