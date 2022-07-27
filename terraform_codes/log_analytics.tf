resource "random_id" "log_analytics_workspace_name_suffix" {
  byte_length = 8
}

resource "azurerm_log_analytics_workspace" "demo_la" {
  name                = "${var.log_analytics_workspace_name}-${random_id.log_analytics_workspace_name_suffix.dec}"
  location            = azurerm_resource_group.demorg.location
  resource_group_name = azurerm_resource_group.demorg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}