########################################################################################
# Linux VM
########################################################################################

variable "network_interface" {
    description = "Map of azure Network Interfaces"
    type = map(object({
        name    = string
        location = string
        resource_group_name = string
        ip_configuration = object({
          name = string
          subnet_id = string
          private_ip_address_allocation = string # "Dynamic", "Static"
        })
    }))
    
  
}


variable "linux_vm" {
  description = "Map of linux Virtual Machines"
  type = map(object({
    name = string
    resource_group_name = string
    location = string
    size = string
    admin_username = string
    network_interface_ids = list(string)
    # admin_ssh_key = object({
    #   name = string
    # })
    os_disk = object({
      caching = optional(string)
      storage_account_type = optional(string) # LRS, ZRS
    })
    # source_image_reference = object({
    #   publisher = optional(string)
    #   offer = optional(string)
    #   sku = optional(string)
    #   version  = optional(string)
    # })
  }))
#   default = {
#     source_image_reference = {
#         publisher = "Canonical"
#         offer     = "0001-com-ubuntu-server-jammy"
#         sku       = "22_04-lts"
#         version   = "latest"
#     }
#     os_disk = {
#         caching              = "ReadWrite"
#         storage_account_type = "Standard_LRS"

#     }

#   }
}
