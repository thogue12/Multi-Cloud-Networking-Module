##############################################################################################################
# Virtual Network Peering Variables
##############################################################################################################


variable "virtual_network_peering" {
  description = "Map of virtual network peerings"
  type = map(object({
    name    = string
    resource_group_name = string
    virtual_network_name = string
    remote_virtual_network_id = string
    allow_virtual_network_access = optional(bool)
    allow_forwarded_traffic = optional(bool)

  }))
}