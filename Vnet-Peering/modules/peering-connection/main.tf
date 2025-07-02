##############################################################################################################
# Virtual Network Peering
##############################################################################################################



resource "azurerm_virtual_network_peering" "this" {
  for_each                  = var.virtual_network_peering  
  name                      = each.value.name
  resource_group_name       = each.value.resource_group_name
  virtual_network_name      = each.value.virtual_network_name
  remote_virtual_network_id = each.value.remote_virtual_network_id
}