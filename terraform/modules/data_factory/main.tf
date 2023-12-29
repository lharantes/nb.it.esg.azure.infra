resource "azurerm_data_factory" "adf" {
  name                = var.adf_name
  location            = var.rg_location
  resource_group_name = var.resource_group_name

  tags = var.tags
}