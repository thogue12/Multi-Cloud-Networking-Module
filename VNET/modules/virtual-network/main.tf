################################################################################
# Virtul Network Module
################################################################################

resource "azurerm_virtual_network" "this" {
    for_each = var.virtual_network
    name = each.value.name
    address_space = each.value.address_space
    location = each.value.location
  resource_group_name = each.value.resource_group_name

    tags = var.tags
  
}