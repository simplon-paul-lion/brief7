resource "azurerm_subnet" "subnet_bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.bf7.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.2.0/24"]
}

resource "azurerm_public_ip" "adresse_bastion" {
  name                ="${var.prefix}-ip_bastion"
  location            = var.location
  resource_group_name = azurerm_resource_group.bf7.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  name                = "${var.prefix}-bastion"
  location            = var.location
  resource_group_name = azurerm_resource_group.bf7.name
  tunneling_enabled   = true
  sku                 = "Standard"

  ip_configuration {
    name                 = "${var.prefix}-config_bastion"
    subnet_id            = azurerm_subnet.subnet_bastion.id
    public_ip_address_id = azurerm_public_ip.adresse_bastion.id
  }
}