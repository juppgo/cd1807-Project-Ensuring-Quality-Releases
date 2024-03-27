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
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDOn1mYyj+TSyHydR9nm+Bye5PN95u1T54foVBSxIeFnNm24M+HM0Pej7ywtLVPQl9KXyueMhyW8zDBYE+hYRJYh9GhUkyrZ+e0qYUf/qOI3lhkCfTW+svRX/6C23fUd09Akb8leWdUkZTA0bb4cRzFt80AW76Pp1TXkn2REC0q0VTiFJbP6yYPdLJRBXZEmdEaVfUif47DzUvHackl9v1tSm4hFe8vHHV5mqkhc0FtRn3A08IZGMiCo3RSmlXL8UUka22TKNG4MkFoof2iSspSV5L3R1ExLN/X2tVmDZp7hkTrtTKR9b0ctBtK/jcYm/udNd4sROzlgU3lrVnEYx/9+ksAlSU1OkugcAlJBwF514TMS0hA/YjwYtty9eajdpcF1d6gLAefzvWAoj7y/yj0/Qsk32vErNZ+3uZRo3bPx1arB+uUzMtoSdDx17DvgLsSWTesbpki0YrkxSeuFffjb9bfTKuJnVmKsx+ciOTO+SpTtQhVCl6/eC9sV73RxgM= odl_user@SandboxHost-638471352743976713"
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
