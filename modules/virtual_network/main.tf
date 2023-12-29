data "azurerm_resource_group" "rg_vnet" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  location            = data.azurerm_resource_group.rg_vnet.location
  address_space       = var.address_space
  dns_servers         = var.dns_servers

  tags = var.vnet_tags
}

resource "azurerm_subnet" "subnet" {
  for_each = {
    for key, value in var.subnet :
    key => value
  }
  name                 = each.key
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name

  address_prefixes  = each.value.address_prefix
  service_endpoints = each.value.service_endpoints == [""] ? null : each.value.service_endpoints
}