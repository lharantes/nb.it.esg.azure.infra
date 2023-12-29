resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = var.dns_private_zone
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
  name                  = join("-", ["vnet-link", var.vnet_name])
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  virtual_network_id    = var.vnet_id
}
