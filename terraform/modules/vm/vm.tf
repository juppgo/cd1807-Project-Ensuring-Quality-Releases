resource "azurerm_network_interface" "nic" {
  name                = "nic_vm"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id_test
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_address_id
  }
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                  = "myLinuxVM"
  location              = "${var.location}"
  resource_group_name   = "${var.resource_group_name}"
  size                  = "Standard_B1s"
  admin_username        = "${var.admin_username}"
  #admin_password = "${var.admin_password}"
  #disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.nic.id]
  source_image_id       = "${var.packer_image}"
  admin_ssh_key {
    username   = "adminuser"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDdYfN+1P/co1rOE62TciaEGUK7cg4aenIrSBaqeANRRDGnXX1SXWRfZWsvxkMq/7ZYP0gFs7I6jOVdS0AmoqBr94hMEpXsW90A0eMmZIvhHN+Y5ZSq7luXzYuXJIB17ZaarYZJUFKvSXsPb8rbdMQ3MJr64lgQO0kp4JHKmFVGonnWPy08wMP8ndw14RCOdBdVc16+8JoeDKxNI9YPgVc3C8UavZUurWumS1UYoBm3/Je/r3S9wYIbcZ3nC7bB9TEYfx4m4PtYQQ/wlJrhsguVMIt4bTT2XwAVE5M/2Jz32xibrrrV4yWbvAB79yyAm4TI2zzgD6BRAYJuant4OvpCWq3VkpULwtr9j9uyL+i+f0dHwC0WZOv2u0AQqH729sgrFx+6Xc8J934yf5JL0SsGbgYJ5gVJtq5ba0X4FWa/SP4VD8hSZdXQUWM4KpzMIGJOXV5k/L4OlOMaEmT0qfn3XakNscy6DTmJQBlqATjA5j7bjDDYJmAW7GzBhg6AkSc= odl_user@SandboxHost-638471971768091188"
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  #source_image_reference {
  #  publisher = "Canonical"
  #  offer     = "UbuntuServer"
  #  sku       = "18.04-LTS"
  #  version   = "latest"
  #}
}
