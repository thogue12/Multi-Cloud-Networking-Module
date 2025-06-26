#########################################################################################
# Storage Account Variables
#########################################################################################

variable "storage_accounts" {
    description = "Map of storage accounts to create"
    type = map(object({
        name = string
        location = string
        resource_group_name = string
        account_tier = string # e.g. "Standard", "Premium"
        account_replication_type = string # e.g. "Standard_LRS", "Premium_LRS", etc.
  }))
}


#########################################################################################
# Container Variables
#########################################################################################

variable "storage_containers" {
  description = "Map of storage containers to create"
  type = map(object({
    name = string
    storage_account_id = string
    container_access_type = string # e.g. "private", "blob", "container"
    }))
}

variable "tags" {
  description = "Tags to apply to the storage accounts and containers"
  type = map(string)
  
}