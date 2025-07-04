output "virutal_network_name" {
  description = "The name of the virtual network."
  value       = {for k, v in azurerm_virtual_network.this : k => v.name}
  
}

output "virutal_network_id" {
  description = "The ID of the virtual network."
  value       = {for k, v in azurerm_virtual_network.this : k => v.id}
  
}
output "vnet_address_space" {
   description = "The address space of the virtual network."
   value = {for k, v in azurerm_virtual_network.this : k => v.address_space}  

}
    
  
