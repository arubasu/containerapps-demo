resource "azurerm_container_registry" "acr" {
  name                = var.container_registry
  resource_group_name = azurerm_resource_group.demorg.name
  location            = azurerm_resource_group.demorg.location
  sku                 = "Basic"
  admin_enabled       = true
  tags                = var.tags
}