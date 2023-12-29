resource "azurerm_log_analytics_workspace" "log" {
  name                = var.log_ws_name
  location            = var.rg_location
  resource_group_name = var.resource_group_name
  sku                 = var.sku_log_ws
  retention_in_days   = var.log_retention_days

  tags = var.tags
}