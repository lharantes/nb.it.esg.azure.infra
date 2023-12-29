# ---------------------------------------------------------------------------------------------------------------------
# Resource Groups
# ---------------------------------------------------------------------------------------------------------------------
resource "azurerm_resource_group" "rg_adf" {
  name = join("-", ["rg", lookup(local.regions, var.location, ""), var.sufix_project, var.environment])


  location = var.location
  tags     = merge(var.global_tags, var.rg_tags)
}

resource "azurerm_resource_group" "rg_networking" {
  name     = join("-", ["rg", lookup(local.regions, var.location, ""), "networking", var.sufix_project])
  location = var.location
  tags     = merge(var.global_tags, var.rg_tags)
}

resource "azurerm_resource_group" "rg_common" {
  name     = join("-", ["rg", lookup(local.regions, var.location, ""), var.sufix_project, var.sufix_common])
  location = var.location
  tags     = merge(var.global_tags, var.rg_tags)
}

# ---------------------------------------------------------------------------------------------------------------------
# Networks
# ---------------------------------------------------------------------------------------------------------------------

module "module_vnet" {
  source = "./modules/virtual_network"

  vnet_name           = join("-", ["vnet", lookup(local.regions, var.location, ""), var.sufix_project])
  resource_group_name = azurerm_resource_group.rg_networking.name
  address_space       = var.vnet_address_space
  dns_servers         = var.vnet_dns_server != null ? var.vnet_dns_server : []
  subnet              = var.subnet
  vnet_tags           = merge(var.global_tags, var.vnet_tags)

  depends_on = [azurerm_resource_group.rg_networking]
}

# ---------------------------------------------------------------------------------------------------------------------
# Route Table
# ---------------------------------------------------------------------------------------------------------------------

module "module_route_table_env" {
  source = "./modules/route_table"

  route_table_name = join("-", ["rt", lookup(local.regions, var.location, ""), var.sufix_project, var.environment])
  rg_location      = var.location
  rg_name          = azurerm_resource_group.rg_networking.name
  routes           = var.route_table_01
  tags             = var.route_tags
  subnet_id = {
    subnet1 = module.module_vnet.subnet_id[var.subnet_env]
  }

  depends_on = [module.module_vnet]
}

module "module_route_table_common" {
  source = "./modules/route_table"

  route_table_name = join("-", ["rt", lookup(local.regions, var.location, ""), var.sufix_project, "nprd", "common"])
  rg_location      = var.location
  rg_name          = azurerm_resource_group.rg_networking.name
  routes           = var.route_table_common
  tags             = var.route_tags
  subnet_id = {
    subnet1 = module.module_vnet.subnet_id[var.subnet_common]
  }

  depends_on = [module.module_vnet]
}

# ---------------------------------------------------------------------------------------------------------------------
# Networks Security Group
# ---------------------------------------------------------------------------------------------------------------------

module "module_nsg_01" {
  source = "./modules/nsg"

  nsg_name    = join("-", ["nsg", lookup(local.regions, var.location, ""), var.sufix_project, var.environment])
  rg_name     = azurerm_resource_group.rg_networking.name
  rg_location = var.location
  nsgrules    = var.nsgrules
  subnet_id   = module.module_vnet.subnet_id[var.subnet_env]
  tags        = merge(var.global_tags, var.nsg_tags)

  depends_on = [module.module_vnet]
}

module "module_nsg_common" {
  source = "./modules/nsg"

  nsg_name    = join("-", ["nsg", lookup(local.regions, var.location, ""), var.sufix_project, var.sufix_common])
  rg_name     = azurerm_resource_group.rg_networking.name
  rg_location = var.location
  nsgrules    = var.nsgrules_common
  subnet_id   = module.module_vnet.subnet_id[var.subnet_common]
  tags        = merge(var.global_tags, var.nsg_tags)

  depends_on = [module.module_vnet]
}

# ---------------------------------------------------------------------------------------------------------------------
# Storage Account
# ---------------------------------------------------------------------------------------------------------------------=

module "module_storage" {
  source = "./modules/storage_account"

  storage_name        = "bdso${var.sufix_project}${var.environment}0000001"
  resource_group_name = azurerm_resource_group.rg_adf.name
  location            = var.location
  tier                = var.tier
  kind                = var.kind
  replication         = var.replication
  tags                = merge(var.global_tags, var.storage_tags)

  public_access_enabled  = var.public_access_enabled
  network_access_enabled = var.network_access_enabled
  subnet_allowed         = module.module_vnet.subnet_id[var.subnet_env]
  vnet_storage           = module.module_vnet.vnet_id

  storage_containers = var.storage_containers
  storage_shares     = var.storage_shares

  depends_on = [azurerm_resource_group.rg_adf, module.module_vnet]
}

# ---------------------------------------------------------------------------------------------------------------------
# Data Factory
# ---------------------------------------------------------------------------------------------------------------------

module "module_data_factory" {
  source = "./modules/data_factory"

  adf_name            = join("-", ["bdso222", "adf", var.sufix_project, var.environment])
  resource_group_name = azurerm_resource_group.rg_adf.name
  rg_location         = var.location
  depends_on          = [module.module_storage]
  tags                = merge(var.global_tags, var.adf_tags)
}

# ---------------------------------------------------------------------------------------------------------------------
# Private DNS Zone - privatelink.blob.core.windows.net
# ---------------------------------------------------------------------------------------------------------------------

module "module_private_dns_blob" {
  source = "./modules/private_dns"

  resource_group_name = azurerm_resource_group.rg_adf.name

  vnet_name        = module.module_vnet.vnet_name
  vnet_id          = module.module_vnet.vnet_id
  dns_private_zone = lookup(local.dns_private_endpoint, "blob", "")

  depends_on = [module.module_vnet]
}

# ---------------------------------------------------------------------------------------------------------------------
# Private DNS Zone - privatelink.datafactory.azure.net
# ---------------------------------------------------------------------------------------------------------------------

module "module_private_dns_datafactory" {
  source = "./modules/private_dns"

  resource_group_name = azurerm_resource_group.rg_adf.name

  vnet_name        = module.module_vnet.vnet_name
  vnet_id          = module.module_vnet.vnet_id
  dns_private_zone = lookup(local.dns_private_endpoint, "dataFactory", "")

  depends_on = [module.module_vnet]
}

# ---------------------------------------------------------------------------------------------------------------------
# Private Endpoint - Storage Account
# ---------------------------------------------------------------------------------------------------------------------

module "module_private_endpoint_storage_account" {
  source = "./modules/private_endpoint"

  private_endpoint_name = var.private_endpoint_name
  resource_id           = module.module_storage.storage_account_id
  resource_group_name   = azurerm_resource_group.rg_adf.name
  location              = var.location
  dns_private_zone      = module.module_private_dns_blob.private_dns_zone_id

  vnet_id        = module.module_vnet.vnet_id
  subnet_allowed = module.module_vnet.subnet_id[var.subnet_env]

  subresource_names    = ["blob"]
  is_manual_connection = var.is_manual_connection

  depends_on = [module.module_storage, module.module_vnet, module.module_private_dns_blob]
}

# ---------------------------------------------------------------------------------------------------------------------
# Private Endpoint - Data Factory
# ---------------------------------------------------------------------------------------------------------------------

module "module_private_endpoint_data_factory" {
  source = "./modules/private_endpoint"

  private_endpoint_name = var.private_endpoint_name_adf
  resource_id           = module.module_data_factory.data_factory_id
  resource_group_name   = azurerm_resource_group.rg_adf.name
  location              = var.location
  dns_private_zone      = module.module_private_dns_datafactory.private_dns_zone_id

  vnet_id        = module.module_vnet.vnet_id
  subnet_allowed = module.module_vnet.subnet_id[var.subnet_env]

  subresource_names = ["portal"]

  is_manual_connection = var.is_manual_connection_adf

  depends_on = [module.module_data_factory, module.module_vnet, module.module_private_dns_datafactory]
}

# ---------------------------------------------------------------------------------------------------------------------
# KeyVault
# ---------------------------------------------------------------------------------------------------------------------

module "module_key_vault" {
  source = "./modules/keyvault"

  location            = var.location
  resource_group_name = azurerm_resource_group.rg_adf.name
  kv_name             = var.kv_name
  kv_sku              = var.kv_sku
  kv_secrets          = var.kv_secrets
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id_permissions = {
    kvpol1 = {
      object_id          = data.azurerm_client_config.current.object_id
      secret_permissions = ["Get", "List", "Set", "Delete"]
    }
  }
  tags = merge(var.global_tags, var.keyvault_tags)
}
