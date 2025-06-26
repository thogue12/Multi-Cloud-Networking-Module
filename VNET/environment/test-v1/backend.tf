terraform {
  backend "azurerm" {
    resource_group_name  = "tf_state"
    storage_account_name = "tfstatefile84"
    container_name       = "testtfstate"
    key                  = "multiclonetwork.terraform.tfstate"
    subscription_id = ""
  }
}