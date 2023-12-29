resource "azurerm_private_endpoint" "private_endpoint" {
  name                = var.private_endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_allowed

  private_service_connection {
    name                           = join("-", ["pvt-conn", var.private_endpoint_name])
    private_connection_resource_id = var.resource_id
    subresource_names              = var.subresource_names
    is_manual_connection           = var.is_manual_connection
  }
}