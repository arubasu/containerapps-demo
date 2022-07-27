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
  address_prefixes     = ["10.0.2.0/24"]
}