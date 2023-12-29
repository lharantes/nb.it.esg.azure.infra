data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  name                     = var.kv_name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  tenant_id                = var.tenant_id
  purge_protection_enabled = false
  sku_name                 = var.kv_sku

  tags = var.tags
}

resource "azurerm_key_vault_access_policy" "keyvault_policy" {
  for_each = {
    for key, value in var.object_id_permissions :
    key => value
  }
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = var.tenant_id

  object_id          = each.value.object_id
  secret_permissions = each.value.secret_permissions
}

# Generate a random password
resource "random_password" "password" {
  for_each    = var.kv_secrets
  length      = 20
  min_upper   = 2
  min_lower   = 2
  min_numeric = 2
  min_special = 2

  keepers = {
    name = each.key
  }
}

resource "azurerm_key_vault_secret" "secret" {
  for_each     = var.kv_secrets
  key_vault_id = azurerm_key_vault.keyvault.id
  name         = each.key
  value        = lookup(each.value, "value") != "" ? lookup(each.value, "value") : random_password.password[each.key].result
  depends_on = [
    azurerm_key_vault.keyvault,
    azurerm_key_vault_access_policy.keyvault_policy,
  ]
}