variable "resource_group_name" {
  type        = string
  description = "Log Analytics Resource Group"
}

variable "rg_location" {
  type        = string
  description = "Log Analytics location"
}

variable "log_ws_name" {
  type        = string
  description = "Log Analytics Workspace name"
}

variable "sku_log_ws" {
  type        = string
  description = "Log Analytics Workspace SKU"
  validation {
    condition     = can(regex("Free|PerGB2018|PerNode|Premium|Standalone|Standard|CapacityReservation|Unlimited", var.sku_log_ws))
    error_message = "Values allowed as SKU: Free, PerGB2018, PerNode, Premium, Standalone, Standard, CapacityReservation, Unlimited"
  }
}

variable "log_retention_days" {
  type        = number
  description = "Log Analytics Workspace retention in Days"
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Character map identifying through `key = value` what the resource tags are."
}