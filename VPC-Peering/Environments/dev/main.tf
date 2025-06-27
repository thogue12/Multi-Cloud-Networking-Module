locals {
  region   = "us-east-1"
  region_2 = "us-east-1"
  tags = {
    Environment = "dev"
    Project     = "VPC-Peering"
    Owner       = "Smooth"
  }

  name = "vpc-peering-dev"

  vpc_names = {
    requester = "${local.name}-requester"
    accepter  = "${local.name}-accepter"
  }
}


###################################################################
# VPC Module
###################################################################

module "vpc" {
  source = "../../../VPC/Modules/vpc"


  tags = local.tags
  # name = local.name
  vpc_attributes = {
    "requester_vpc" = {
      cidr_block           = "10.0.0.0/16"
      enable_dns_support   = true
      enable_dns_hostnames = true
      region               = local.region
      name                 = local.vpc_names.requester
    },
    "accepter_vpc" = {
      cidr_block           = "10.10.0.0/16"
      enable_dns_support   = true
      enable_dns_hostnames = true
      region               = local.region_2
      name                 = local.vpc_names.accepter

    }
  }
}

###################################################################
# Subnet Module
###################################################################

module "subnets" {
  source = "../../../VPC/modules/subnets"
  name   = local.name
  tags   = local.tags

  private_subnets = {
    "requester-priv-subnet-1" = {
      cidr_block              = ["10.0.0.0/24"]
      availability_zone       = ["us-east-1a"]
      map_public_ip_on_launch = false
      vpc_id                  = module.vpc.vpc_id["requester_vpc"]
    }

    "accepter-priv-subnet-1" = {
      cidr_block              = ["10.10.0.0/24"]
      availability_zone       = ["us-east-1a"]
      map_public_ip_on_launch = false
      vpc_id                  = module.vpc.vpc_id["accepter_vpc"]
    }
  }
  public_subnets = {
    "requester-pub-subnet-2" = {
      cidr_block              = ["10.0.1.0/24"]
      availability_zone       = ["us-east-1b"]
      map_public_ip_on_launch = true
      vpc_id                  = module.vpc.vpc_id["requester_vpc"]

    }
    "accepter-pub-subnet-2" = {
      cidr_block              = ["10.10.1.0/24"]
      availability_zone       = ["us-east-1b"]
      map_public_ip_on_launch = true
      vpc_id                  = module.vpc.vpc_id["accepter_vpc"]
    }
  }
}

###################################################################
# VPC Peering Module```
###################################################################

module "peerings" {
  source = "../../modules/single-vpc-to-vpc-v2"

  vpc_peering_connection = {
    "peering_connection" = {
      vpc_id      = module.vpc.vpc_id["requester_vpc"] # Requester VPC ID
      peer_vpc_id = module.vpc.vpc_id["accepter_vpc"]  # accepter VPC ID

      auto_accept = true # Auto accept the connection
      name        = "requester-peering"

    }
  }
  vpc_peering_accepter = {
    accepter-peer = {
      vpc_peering_connection_id = module.peerings.this_connection["peering_connection"] # VPC Peering Connection ID
      auto_accept               = true
      name                      = "accepter-peer" # Auto accept the connection   
    }
  }

  tags       = local.tags
  depends_on = [module.vpc, module.subnets]

}

###################################################################
# IGW - NAT Module
###################################################################

module "igw-nat" {
  source = "../../../VPC/modules/igw-nat"
  eip = {
    requester_eip = {}
    accepter_eip  = {}
  }

  nat_gateway = {
    requester-nat = {
      allocation_id = module.igw-nat.allocation_id["requester_eip"]
      subnet_id     = module.subnets.public_subnets["requester-pub-subnet-2"]
    }
    accepter-nat = {
      allocation_id = module.igw-nat.allocation_id["accepter_eip"]
      subnet_id     = module.subnets.public_subnets["accepter-pub-subnet-2"]
    }
  }
  internet_gateway = {
    requester-igw = {
      vpc_id = module.vpc.vpc_id["requester_vpc"]
    }
    accepter-igw = {
      vpc_id = module.vpc.vpc_id["accepter_vpc"]
    }
  }
  tags = local.tags
  name = "${local.name}-igw"

}

###################################################################
# Route table Module
###################################################################

module "route-tables" {
  source = "../../../VPC/modules/route-tables"

  tags = local.tags
  name = local.name
  public_route_tables = {
    requester_pub_rt = {
      vpc_id = module.vpc.vpc_id["requester_vpc"]
    }
    accepter_pub_rt = {
      vpc_id = module.vpc.vpc_id["accepter_vpc"]
    }
  }

  private_route_tables = {
    requester_priv_rt = {
      vpc_id = module.vpc.vpc_id["requester_vpc"]
    }

    accepter_priv_rt = {
      vpc_id = module.vpc.vpc_id["accepter_vpc"]
    }
  }

  ###############################################################################
  # Public Routes
  ###############################################################################
  public_routes = {
    route-requester-igw = {
      vpc_id                 = module.vpc.vpc_id["requester_vpc"]
      route_table_id         = module.route-tables.public_route_table_id["requester_pub_rt"]
      gateway_id             = module.igw-nat.igw_id["requester-igw"]
      destination_cidr_block = "0.0.0.0/0"

    }

    route-accepter-igw = {
      vpc_id                 = module.vpc.vpc_id["accepter_vpc"]
      route_table_id         = module.route-tables.public_route_table_id["accepter_pub_rt"]
      gateway_id             = module.igw-nat.igw_id["accepter-igw"]
      destination_cidr_block = "0.0.0.0/0"
    }
  }
  ###############################################################################
  # Private Routes
  ###############################################################################

  private_routes = {
    route-requester-peer = {
      route_table_id            = module.route-tables.private_route_table_id["requester_priv_rt"]
      vpc_peering_connection_id = module.peerings.this_connection["peering_connection"]
      destination_cidr_block    = module.vpc.vpc_cidr["accepter_vpc"]
    }
    route-requester-nat = {
      route_table_id            = module.route-tables.private_route_table_id["requester_priv_rt"]
      nat_gateway_id            = module.igw-nat.nat_id["requester-nat"]
      destination_cidr_block    = "0.0.0.0/0"
    }
    route-accepter-peer = {
      route_table_id            = module.route-tables.private_route_table_id["accepter_priv_rt"]
      vpc_peering_connection_id = module.peerings.this_connection["peering_connection"]
      destination_cidr_block    = module.vpc.vpc_cidr["requester_vpc"]
    }
    route-accepter-nat = {
      route_table_id            = module.route-tables.private_route_table_id["accepter_priv_rt"]
      nat_gateway_id            = module.igw-nat.nat_id["accepter-nat"]
      destination_cidr_block    = "0.0.0.0/0"
    }

  }

  ###############################################################################
  # Route table associations
  #############################################################################
  public_route_table_associations = {
    pub-requester-assoc = {
      route_table_id = module.route-tables.public_route_table_id["requester_pub_rt"]
      subnet_id      = module.subnets.public_subnets["requester-pub-subnet-2"]
    }
    pub-accepter-assoc = {
      route_table_id = module.route-tables.public_route_table_id["accepter_pub_rt"]
      subnet_id      = module.subnets.public_subnets["accepter-pub-subnet-2"]
    }
  }
  private_route_table_associations = {
    priv-requester-assoc = {
      route_table_id = module.route-tables.private_route_table_id["requester_priv_rt"]
      subnet_id      = module.subnets.private_subnets["requester-priv-subnet-1"]
    }
    priv-accepter-assoc = {
      route_table_id = module.route-tables.private_route_table_id["accepter_priv_rt"]
      subnet_id      = module.subnets.private_subnets["accepter-priv-subnet-1"]
    }
  }

}

########################################################################
# EC2 Module
########################################################################

module "ec2-instance" {
  source = "../../../virtual-machines/AWS/EC2"

  tags = local.tags
  name = local.name

  instance_attributes = {
    requester_instance = {
      instance_type          = "t2.micro"
      iam_instance_profile   = module.ssm_policy.iam_instance_profile
      subnet_id              = module.subnets.private_subnets["requester-priv-subnet-1"]
      vpc_security_group_ids = [module.security-groups.security_group_ids["requester_sg"]]

    }
    accepter_instance = {
      instance_type          = "t2.micro"
      iam_instance_profile   = module.ssm_policy.iam_instance_profile
      subnet_id              = module.subnets.private_subnets["accepter-priv-subnet-1"]
      vpc_security_group_ids = [module.security-groups.security_group_ids["accepter_sg"]]


    }
    accepter_instance2 = {
      instance_type          = "t2.micro"
      iam_instance_profile   = module.ssm_policy.iam_instance_profile
      subnet_id              = module.subnets.public_subnets["accepter-pub-subnet-2"]
      vpc_security_group_ids = [module.security-groups.security_group_ids["accepter_sg"]]


    }
  }

}
########################################################################
# IAM SSM Policy
########################################################################

module "ssm_policy" {
  source = "../../../IAM/SSM-Policy"

}

########################################################################
# Secuirty Group
########################################################################

module "security-groups" {
  source = "../../../vpc/modules/security-groups"
  tags   = local.tags
  name   = local.name

  security_groups = {
    requester_sg = {
      vpc_id      = module.vpc.vpc_id["requester_vpc"]
      description = "requester security group allow icmp"
    }
    accepter_sg = {
      vpc_id      = module.vpc.vpc_id["accepter_vpc"]
      description = "accepter security group allow icmp"
    }
  }
  ingress_rules = {
    requester_ingress_icmp = {
      type              = "ingress"
      from_port         = -1
      to_port           = -1
      protocol          = "icmp"
      security_group_id = module.security-groups.security_group_ids["requester_sg"]
      cidr_blocks       = ["0.0.0.0/0"]

    }
    accepter_ingress_icmp = {
      type              = "ingress"
      from_port         = -1
      to_port           = -1
      protocol          = "icmp"
      security_group_id = module.security-groups.security_group_ids["accepter_sg"]
      cidr_blocks       = ["0.0.0.0/0"]
    }
  }
  egress_rules = {
    requester_egress_rule = {
      security_group_id = module.security-groups.security_group_ids["requester_sg"]
    }
    accepter_egress_rule = {
      security_group_id = module.security-groups.security_group_ids["accepter_sg"]
    }
  }

}