output "subnet_id" {
  description = "The ID of the subnet."
  value       = {for k, v in azurerm_subnet.this : k => v.id}
  
}
output "subnet_address_prefixes" {
    description = "subnet address prefixes aka subnet CIDR."
    value = {for k, v in azurerm_subnet.this : k => v.address_prefixes}
}