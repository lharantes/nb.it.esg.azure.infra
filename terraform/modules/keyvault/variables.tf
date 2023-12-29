variable "kv_name" {
  type        = string
  description = "Key Vault name, the name is Global Unique"
}

variable "resource_group_name" {
  type        = string
  description = "Key Vault Resource Group"
}

variable "location" {
  type        = string
  description = "Key Vault location"
}

variable "kv_sku" {
  type        = string
  description = "Key Vault SKU"
  validation {
    condition     = can(regex("premium|standard", var.kv_sku))
    error_message = "Values allowed as SKU: Premium or Standard"
  }
}

variable "object_id_permissions" {
  type = map(object({
    object_id          = string
    secret_permissions = list(string)
  }))
}

variable "kv_secrets" {
  type = map(object({
    value = string
  }))
  description = "Define Azure Key Vault secrets"
  default     = {}
}

variable "tenant_id" {
  type        = string
  description = "Tenant ID where the resources are being deployed"
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Character map identifying through `key = value` what the resource tags are."
}