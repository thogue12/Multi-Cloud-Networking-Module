####################################################################################
# Network Security Group Module
####################################################################################

resource "azurerm_network_security_group" "this" {
  for_each = var.network_security_groups
  name = each.value.name
  location = each.value.location
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_network_security_rule" "this" {
  for_each = var.network_security_group_rules
  name = each.value.name
  priority = each.value.priority
  direction = each.value.direction
  access = each.value.access
  protocol = each.value.protocol
  source_address_prefix = each.value.source_address_prefix
  destination_address_prefix = each.value.destination_address_prefix
  source_port_range = each.value.source_port_range
  destination_port_range = each.value.destination_port_range
  network_security_group_name = azurerm_network_security_group.this[each.value.target_nsg_key].name
  resource_group_name         = azurerm_network_security_group.this[each.value.target_nsg_key].resource_group_name
}

