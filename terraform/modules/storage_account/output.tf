output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "storage_account_id" {
  value = azurerm_storage_account.storage.id
}

output "storage_account_blob_url" {
  value = azurerm_storage_account.storage.primary_blob_endpoint
}

output "storage_connection_string" {
  value = azurerm_storage_account.storage.primary_connection_string
}

output "storage_container_name" {
  value = [for container_name in azurerm_storage_container.container : container_name.name]
}

output "primary_dfs_endpoint" {
  value = azurerm_storage_account.storage.primary_dfs_endpoint
}
