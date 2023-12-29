terraform {
  backend "azurerm" {
    resource_group_name  = "RG-TERRAFORM-STATE"
    storage_account_name = "stotfstatearantes"
    container_name       = "tfstate"
    key                  = "terraform.tfstate.${var.environment}"
  }
}
provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
}

data "azurerm_client_config" "current" {}