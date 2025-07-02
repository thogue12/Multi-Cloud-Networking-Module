########################################################################################
# Linux VM
########################################################################################

resource "azurerm_network_interface" "this"{
    for_each = var. network_interface
    name = each.value.name
    location = each.value.location
    resource_group_name = each.value.resource_group_name
  ip_configuration {
    name = each.value.ip_configuration.name
    subnet_id = each.value.ip_configuration.subnet_id
    private_ip_address_allocation = each.value.ip_configuration.private_ip_address_allocation
  }
}

resource "azurerm_linux_virtual_machine" "this" {
  for_each = var.linux_vm
  name = each.value.name
  resource_group_name = each.value.resource_group_name
  location = each.value.location
  size = each.value.size
  admin_username = "adminuser"
  network_interface_ids = each.value.network_interface_ids

  os_disk {
    caching = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
  }
 source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
    admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }
}