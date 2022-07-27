resource "azurerm_resource_group" "demorg" {
  name     = var.resource_group
  location = var.location
  tags     = var.tags
}