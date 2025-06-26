#########################################################################################
# Storage Account 
#########################################################################################

resource "azurerm_storage_account" "this" {
    for_each = var. storage_accounts
    name = each.value.name
    resource_group_name = each.value.resource_group_name
    location = each.value.location
    account_tier = each.value.account_tier
    account_replication_type = each.value.account_replication_type

    tags = var.tags


  
}

#########################################################################################
# Container Variables
#########################################################################################
resource "azurerm_storage_container" "this" {
    for_each = var.storage_containers
    name = each.value.name
    storage_account_id = each.value.storage_account_id
    container_access_type = each.value.container_access_type

    depends_on = [ azurerm_storage_account.this ]
}