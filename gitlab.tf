resource "azurerm_public_ip" "ip-infra" {
  name                ="${var.prefix}-ip_infra"
  location            = var.location
  resource_group_name = azurerm_resource_group.bf7.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "gitlab-nic" {
  name                = "${var.prefix}-gitlab-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.bf7.name

  ip_configuration {
    name                          = "${var.prefix}-config-gitlab"
    subnet_id                     = azurerm_subnet.sub-infra.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.1.1.10"
    public_ip_address_id = azurerm_public_ip.ip-infra.id
  }
}

resource "azurerm_linux_virtual_machine" "gitlab" {
  name                  = "${var.prefix}-gitlab"
  resource_group_name   = azurerm_resource_group.bf7.name
  location              = var.location
  size                  = "Standard_A2_v2"
  network_interface_ids = [azurerm_network_interface.gitlab-nic.id]
  
  #custom_data           = data.template_cloudinit_config.cloudinit.rendered

  admin_ssh_key {
    username   = "${var.admin}"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    name                 = "${var.prefix}-gitlab-osDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Debian"
    offer     = "debian-11"
    sku       = "11"
    version   = "latest"
  }

  computer_name                   = "gitlab-svr"
  disable_password_authentication = true
  admin_username                  = "${var.admin}"
}