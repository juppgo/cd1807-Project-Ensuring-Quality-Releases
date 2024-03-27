resource "azurerm_network_interface" "nic" {
  name                = "nic_vm"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = ""
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = ""
  }
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                  = "myLinuxVM"
  location              = "${var.location}"
  resource_group_name   = "${var.resource_group_name}"
  size                  = "Standard_B1s"
  admin_username        = "${var.admin_username}"
  admin_password = "${var.admin_password}"
  #disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.nic.id]
  #source_image_id       = "${var.packer_image}"
  #admin_ssh_key {
  #  username   = "adminusername"
  #  public_key = "file("~/.ssh/id_rsa.pub")"
  #}
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
