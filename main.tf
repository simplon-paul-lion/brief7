resource "azurerm_resource_group" "bf7" {
  name     = "${var.prefix}"
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  resource_group_name = azurerm_resource_group.bf7.name
  location            = var.location
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "sub-infra" {
  name                 = "${var.prefix}-subinfra"
  resource_group_name  = azurerm_resource_group.bf7.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.1.0/24"]
}

resource "azurerm_network_security_group" "nsg-infra" {
  name                = "${var.prefix}-nsginfra"
  location            = var.location
  resource_group_name = azurerm_resource_group.bf7.name

  security_rule {
    name                       = "nsg-rule"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["22"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "nsg-rule2"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["80"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsginfra" {
  subnet_id = azurerm_subnet.sub-infra.id
  network_security_group_id = azurerm_network_security_group.nsg-infra.id
  }

