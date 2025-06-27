

locals {
  environment     = "test-v1"
  vnet_name       = "vnet-${local.environment}"
  location        = "eastus"
  second_location = "westus"
  name            = "smooth"
  global_name     = "${local.name}-${local.environment}"
  tags = {
    environment = local.environment
    name        = local.name
  }
  vnet_address_space  = ["10.0.0.0/16"]
  vnet2_address_space = ["10.10.0.0/16"]
}

#####################################################################
# Resource Group Module
#######################################################################
module "resource_group" {
  source = "../../../VNET/modules/resource-group"

  resource_groups = {
    requester_rg = {
      name     = "requester_rg"
      location = local.location
    }
    accepter_rg = {
      name     = "accepter_rg"
      location = local.location
    }
  }
  tags = local.tags
}


################################################################################
# Virtul Network Module
################################################################################

module "virtual_network" {
  source = "../../../VNET/modules/virtual-network"

  virtual_network = {
    requester_vnet = {
      name                = "requester_vnet"
      address_space       = local.vnet_address_space
      location            = local.location
      resource_group_name = module.resource_group.resource_group_name["requester_rg"]
    }

    accepter_vnet = {
      name                = "accepter_vnet"
      address_space       = local.vnet2_address_space
      location            = local.location
      resource_group_name = module.resource_group.resource_group_name["accepter_rg"]
    }

  }
  tags = local.tags
}

################################################################################
# Subnet Module
################################################################################

module "subnets" {
  source = "../../../VNET/modules/subnet"

  subnets = {
    requester_pub_sub1 = {
      name                 = "requester_pub_sub1"
      address_prefixes     = ["10.0.0.0/24"]
      virtual_network_name = module.virtual_network.virutal_network_name["requester_vnet"]
      resource_group_name  = module.resource_group.resource_group_name["requester_rg"]
    }
    requester_pub_sub2 = {
      name                 = "requester_pub_sub2"
      address_prefixes     = ["10.0.1.0/24"]
      virtual_network_name = module.virtual_network.virutal_network_name["requester_vnet"]
      resource_group_name  = module.resource_group.resource_group_name["requester_rg"]
    }
    accepter_pub_sub1 = {
      name                 = "accepter_pub_sub1"
      address_prefixes     = ["10.10.0.0/24"]
      virtual_network_name = module.virtual_network.virutal_network_name["accepter_vnet"]
      resource_group_name  = module.resource_group.resource_group_name["accepter_rg"]
    }
    accepter_pub_sub2 = {
      name                 = "accepter_pub_sub2"
      address_prefixes     = ["10.10.1.0/24"]
      virtual_network_name = module.virtual_network.virutal_network_name["accepter_vnet"]
      resource_group_name  = module.resource_group.resource_group_name["accepter_rg"]
    }
  }

}

##############################################################################################################
# Virtual Network Peering
##############################################################################################################

module "peerings" {
  source = "../../../Vnet-Peering/modules/peering-connection"

  virtual_network_peering = {
    request_accepter = {
      name                         = "requester-accepter"
      resource_group_name          = module.resource_group.resource_group_name["requester_rg"]
      virtual_network_name         = module.virtual_network.virutal_network_name["requester_vnet"]
      remote_virtual_network_id    = module.virtual_network.virutal_network_id["accepter_vnet"]
      allow_virtual_network_access = true
      allow_forwarded_traffic      = true
    }
    accepter_requester = {
      name                         = "requester-accepter"
      resource_group_name          = module.resource_group.resource_group_name["accepter_rg"]
      virtual_network_name         = module.virtual_network.virutal_network_name["accepter_vnet"]
      remote_virtual_network_id    = module.virtual_network.virutal_network_id["requester_vnet"]
      allow_virtual_network_access = true
      allow_forwarded_traffic      = true
    }
  }

}

