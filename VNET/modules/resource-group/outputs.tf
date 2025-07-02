output "resource_group_name" {
  description = "The name of the resource group."
  value       = {for k ,v in azurerm_resource_group.this : k => v.name}
  
}

output "location" {
  description = "The location of the resource group."
  value       = {for k ,v in azurerm_resource_group.this : k => v.location}
  
}