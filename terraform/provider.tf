provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
  subscription_id = "8d7c6fb5-f932-4e13-ba06-fdf554f7527a"
  tenant_id       = "637be5c4-cfcf-4c1e-af85-fd7ecadb26a2"
}

data "azurerm_client_config" "current" {}