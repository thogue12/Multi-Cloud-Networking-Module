output "network_interface_ids" {
  description = "map of network interface IDs"
  value =  {for k, v in azurerm_network_interface.this : k => v.id }
}

output "azurerm_linux_virtual_machine" {
  description = " Map of linux VM Ids"
  value = {for k,v in azurerm_linux_virtual_machine.this : k => v.id}
}