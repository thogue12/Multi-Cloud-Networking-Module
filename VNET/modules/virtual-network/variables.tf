################################################################################
# Virtul Network Variables
################################################################################

variable "virtual_network" {
  description = "Map of virtual networks to create"
  type = map(object({
    name = string
    address_space = list(string)
    location = string
    resource_group_name = string
  }))
}
variable "tags" {
  description = "Tags to apply  all resources"
  type = map(string)
  
}