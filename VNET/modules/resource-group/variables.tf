#####################################################################
# Resource Group Variables
#######################################################################

variable "resource_groups" {
  description = "Map of resource groups to create"
  type = map(object({
    name = string
    location = string
  }))
}

variable "tags"{
    description = "Tags to apply to the resource group"
    type = map(string)
}