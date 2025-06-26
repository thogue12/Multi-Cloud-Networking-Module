#############################################################################################
# Local Variables
#############################################################################################

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

#############################################################################################
# Resource Group Module
#############################################################################################

module "resource_group" {
  source = "../../modules/resource-group"
  resource_groups = {
    smooths_rg1 = {
      name     = "smooths-rg1"
      location = local.location
    }
    smooth_rg2 = {
      name     = "smooth-rg2"
      location = local.second_location
    }
  }
  tags = local.tags

}

#############################################################################################
# Virtual Network Module
#############################################################################################


module "virtual_network" {
  source = "../../modules/virtual-network"
  virtual_network = {
    smooths_vnet1 = {
      name                = local.vnet_name
      address_space       = local.vnet_address_space
      location            = local.location
      resource_group_name = module.resource_group.resource_group_name["smooths_rg1"]
    }
    smooths_vnet2 = {
      name                = local.vnet_name
      address_space       = local.vnet2_address_space
      location            = local.second_location
      resource_group_name = module.resource_group.resource_group_name["smooth_rg2"]
    }

  }
  tags = local.tags
}

#############################################################################################
# Subnet Module
#############################################################################################

module "subnets" {
  source = "../../modules/subnet"
  subnets = {
    smooths_subnet1 = {
      name                 = "smooths-subnet1"
      resource_group_name  = module.resource_group.resource_group_name["smooths_rg1"]
      virtual_network_name = module.virtual_network.virutal_network_name["smooths_vnet1"]
      address_prefixes     = ["10.0.1.0/24"]

      service_endpoints = [
        "Microsoft.Storage",
        "Microsoft.Sql",
      ]
    }
    smooths_subnet2 = {
      name                 = "smooths-subnet2"
      resource_group_name  = module.resource_group.resource_group_name["smooths_rg1"]
      virtual_network_name = module.virtual_network.virutal_network_name["smooths_vnet1"]
      address_prefixes     = ["10.0.2.0/24"]
    }
    smooth_subnet1 = {
      name                 = "smooths-subnet1"
      resource_group_name  = module.resource_group.resource_group_name["smooth_rg2"]
      virtual_network_name = module.virtual_network.virutal_network_name["smooths_vnet2"]
      address_prefixes     = ["10.10.10.0/24"]

    }
    smooth_subnet2 = {
      name                 = "smooths-subnet2"
      resource_group_name  = module.resource_group.resource_group_name["smooth_rg2"]
      virtual_network_name = module.virtual_network.virutal_network_name["smooths_vnet2"]
      address_prefixes     = ["10.10.1.0/24"]

      delegation = {
        name = "delegation1"

        service_delegation = {
          name = "Microsoft.ContainerInstance/containerGroups"
          actions = [
            "Microsoft.Network/networkinterfaces/*",
            "Microsoft.Network/virtualNetworks/subnets/join/action",

          ]
        }
      }
    }
  }
}

#########################################################################################
# Storage Account 
#########################################################################################

module "storage_accounts" {
  source = "../../modules/storage-account"
  storage_accounts = {
    smooths_sa1 = {
      name                     = "smoothssa1"
      resource_group_name      = module.resource_group.resource_group_name["smooths_rg1"]
      location                 = local.location
      account_tier             = "Standard"
      account_replication_type = "LRS"
    }
    smooths_sa2 = {
      name                     = "smoothssa2"
      resource_group_name      = module.resource_group.resource_group_name["smooth_rg2"]
      location                 = local.second_location
      account_tier             = "Standard"
      account_replication_type = "LRS"
    }
  }
  storage_containers = {
    smooths_container1 = {
      name                  = "smooths-container1"
      storage_account_id    = module.storage_accounts.storage_account_id["smooths_sa1"]
      container_access_type = "private"
    }
    smooths_container2 = {
      name                  = "smooths-container2"
      storage_account_id    = module.storage_accounts.storage_account_id["smooths_sa2"]
      container_access_type = "private"
    }
  }
  tags = local.tags
}

#########################################################################################
# Network Security Group
#########################################################################################

module "network_security_group" {
  source = "../../modules/network-security-group"

  network_security_groups = {
    smooths_nsg1 = {
      name                = "smooths-nsg1"
      location            = local.location
      resource_group_name = module.resource_group.resource_group_name["smooths_rg1"]
    }
  }
  network_security_group_rules = {
    smooths_nsg_rule1 = {
      name                       = "smooths-nsg-rule1"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      source_port_range          = "*"
      destination_port_range     = "80"
      target_nsg_key             = "smooths_nsg1"
      resource_group_name        = module.resource_group.resource_group_name["smooths_rg1"]
    }
    smooths_nsg_rule2 = {
      name                       = "smooths-nsg-rule2"
      priority                   = 200
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      source_port_range          = "*"
      destination_port_range     = "443"
      target_nsg_key             = "smooths_nsg1"
      resource_group_name        = module.resource_group.resource_group_name["smooths_rg1"]
    }
  }
  tags = local.tags
}
