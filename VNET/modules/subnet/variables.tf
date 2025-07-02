################################################################################
# Subnet Variables
################################################################################

variable "subnets" {
    description = "Map of subnets to create"
    type = map(object({
        name                = string
        address_prefixes    = list(string)
        virtual_network_name = string
        resource_group_name = string
        service_endpoints   = optional(list(string), [])
        network_security_group_id = optional(string, null)
        delegation = optional(object({
            name = string
            service_delegation = object({
                name = string
                actions = list(string)
            })
        service_endpoints = optional(list(string), []),
        }))
    }))
  
}