####################################################################################
# Network Security Group Variables
####################################################################################


variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}

variable "network_security_groups" {
  description = "Map of network security groups to create"
  type = map(object({
    name = string
    location = string
    resource_group_name = string
  }))
}

variable "network_security_group_rules" {
  description = "Map of network security group rules to create"
  type = map(object({
    name = string
    priority = number
    direction = string # e.g. "Inbound", "Outbound"
    access = string # e.g. "Allow", "Deny"
    protocol = string # e.g. "Tcp", "Udp", "*"
    source_address_prefix = optional(string, "*")
    destination_address_prefix = optional(string, "*")
    source_port_range = optional(string, "*")
    destination_port_range = optional(string, "*")
    target_nsg_key = optional(string, null) # Key to reference the target NSG in the azurerm_network_security_group resource
 
  }))
}