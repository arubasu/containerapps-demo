resource "azurerm_load_test" "demolt" {
  name                = var.load_test
  resource_group_name = azurerm_resource_group.demorg.name
  location            = azurerm_resource_group.demorg.location
  tags                = var.tags
}