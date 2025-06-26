output "storage_account_id" {
  description = "Storage account ID."
  value = {for k, v in azurerm_storage_account.this : k => v.id}
}