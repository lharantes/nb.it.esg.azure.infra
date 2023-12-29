resource "azurerm_storage_account" "storage" {
  name                          = var.storage_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  account_tier                  = var.tier
  account_kind                  = var.kind
  account_replication_type      = var.replication
  public_network_access_enabled = var.public_access_enabled

  tags = var.tags
}

resource "azurerm_storage_account_network_rules" "network_rules" {
  count = var.network_access_enabled == true ? 1 : 0

  storage_account_id = azurerm_storage_account.storage.id
  // Retirar ip_rules e alterar para Deny
  default_action = "Allow"
  ip_rules       = ["170.239.52.35"]
  // ----------------------------------------
  virtual_network_subnet_ids = [var.subnet_allowed]
  bypass                     = ["AzureServices", "Logging", "Metrics"]
}

resource "azurerm_storage_share" "file_share" {
  for_each             = var.storage_shares
  name                 = each.key
  storage_account_name = azurerm_storage_account.storage.name
  enabled_protocol     = each.value.protocol
  quota                = each.value.quota

  depends_on = [
    azurerm_storage_account.storage
  ]
}

resource "azurerm_storage_container" "container" {
  for_each              = var.storage_containers
  name                  = lower(each.value.name)
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = each.value.container_access_type

  depends_on = [
    azurerm_storage_account.storage
  ]
}