data "azurerm_container_registry" "acr" {
  name                = var.container_registry
  resource_group_name = azurerm_resource_group.demorg.name
}

output "acr_login_server" {
  value = data.azurerm_container_registry.acr.login_server
}

output "acr_admin_username" {
  value = data.azurerm_container_registry.acr.admin_username
}

output "acr_admin_password" {
  value     = data.azurerm_container_registry.acr.admin_password
  sensitive = true
}

output "resource_group_name" {
  value = azurerm_resource_group.demorg.name
}

output "location" {
  value = azurerm_resource_group.demorg.location
}

data "azurerm_log_analytics_workspace" "demo_la" {
  name                = azurerm_log_analytics_workspace.demo_la.name
  resource_group_name = azurerm_log_analytics_workspace.demo_la.resource_group_name
}

output "log_analytics_workspace_id" {
  value = data.azurerm_log_analytics_workspace.demo_la.workspace_id
}

output "log_analytics_workspace_shared_key" {
  value     = data.azurerm_log_analytics_workspace.demo_la.primary_shared_key
  sensitive = true
}
/* Using Custom VNET is still in progress.
output "subnet_resource_id" {
  value = azurerm_subnet.subnet.id
}
*/