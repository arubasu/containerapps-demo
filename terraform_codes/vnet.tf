/* Using custom vnet is still in progress
# create virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "AzureFundayDemoVNET"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.demorg.location
  resource_group_name = azurerm_resource_group.demorg.name
  tags                = var.tags
}

# create subnet
resource "azurerm_subnet" "subnet" {
  name                 = "AzureFundayDemoSN"
  resource_group_name  = azurerm_resource_group.demorg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/23"]
}

resource "azurerm_network_security_group" "demo_nsg" {
  name                = "AzureFundayDemoNSG"
  location            = azurerm_resource_group.demorg.location
  resource_group_name = azurerm_resource_group.demorg.name

  security_rule {
    name                       = "Incoming_all"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "nsg-association" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.demo_nsg.id
}
*/