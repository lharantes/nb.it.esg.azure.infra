# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - GLOBAL
# ---------------------------------------------------------------------------------------------------------------------
variable "environment" { type = string }
variable "sufix_project" { type = string }
variable "sufix_common" { type = string }
variable "location" { type = string }
variable "rg_tags" {} # Resource Group Tags
variable "global_tags" { type = map(any) }

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - Networks
# ---------------------------------------------------------------------------------------------------------------------

variable "vnet_address_space" { type = list(any) }
variable "vnet_dns_server" { type = list(any) }
variable "subnet" {
  type = map(object({
    address_prefix    = list(string)
    service_endpoints = list(string)
  }))
}
variable "vnet_tags" {}
variable "subnet_common" { type = string }
variable "subnet_env" { type = string }

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - Route Table
# ---------------------------------------------------------------------------------------------------------------------

variable "route_table_01" { type = map(any) }
variable "route_table_common" { type = map(any) }
variable "route_tags" {}

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - Networks Security Group
# ---------------------------------------------------------------------------------------------------------------------

variable "nsgrules" { type = map(any) }
variable "nsgrules_common" { type = map(any) }
variable "nsg_tags" {}

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - Storage Account
# ---------------------------------------------------------------------------------------------------------------------=

variable "tier" { type = string }
variable "kind" { type = string }
variable "replication" { type = string }
variable "public_access_enabled" { type = bool }
variable "network_access_enabled" { type = bool }
variable "storage_shares" { type = map(any) }
variable "storage_containers" {
  type = map(object({
    name                  = string
    container_access_type = string
  }))
}
variable "storage_tags" {}

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - Data Factory
# ---------------------------------------------------------------------------------------------------------------------

variable "adf_tags" {}

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - Private Endpoint - Storage Account
# ---------------------------------------------------------------------------------------------------------------------

variable "is_manual_connection" {}
variable "private_endpoint_name" {}

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - Private Endpoint - Data Factory
# ---------------------------------------------------------------------------------------------------------------------

variable "is_manual_connection_adf" {}
variable "private_endpoint_name_adf" {}

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - KeyVault
# ---------------------------------------------------------------------------------------------------------------------

variable "kv_name" { type = string }
variable "kv_sku" { type = string }
/*variable "object_id_permissions" {
  type = map(object({
    objetc_ID          = string
    secret_permissions = list(string)
  }))
}*/
variable "kv_secrets" {
  type = map(object({
    value = string
  }))
  default = {}
}
variable "keyvault_tags" {}