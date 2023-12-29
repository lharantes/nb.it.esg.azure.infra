
variable "resource_group_name" {
  type        = string
  description = "Key Vault Resource Group"
}

variable "location" {
  type        = string
  description = "Key Vault location"
}

variable "app_service_plan_name" {
  type        = string
  description = "App Service Plan name"
}

variable "sku_name" {
  type        = string
  description = "The SKU for the app service plan"
  validation {
    condition     = can(regex("B1|B2|B3|D1|F1|I1|I2|I3|I1v2|I2v2|I3v2|I4v2|I5v2|I6v2|P1v2|P2v2|P3v2|P0v3|P1v3|P2v3|P3v3|P1mv3|P2mv3|P3mv3|P4mv3|P5mv3|S1|S2|S3|SHARED|EP1|EP2|EP3|WS1|WS2|WS3|and Y1", var.sku_name))
    error_message = "Allowed values as SKU: B1, B2, B3, D1, F1, I1, I2, I3, I1v2, I2v2, I3v2, I4v2, I5v2, I6v2, P1v2, P2v2, P3v2, P0v3, P1v3, P2v3, P3v3, P1mv3, P2mv3, P3mv3, P4mv3, P5mv3, S1, S2, S3, SHARED, EP1, EP2, EP3, WS1, WS2, WS3, and Y1."
  }
}

variable "os_type" {
  type        = string
  description = "The O/S type for the App Services to be hosted in this plan. Possible values include Windows, Linux, and WindowsContainer"
  validation {
    condition     = can(regex("Windows|Linux|WindowsContainer", var.os_type))
    error_message = "Allowed values as SKU: Windows, Linux, and WindowsContainer."
  }
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Character map identifying through `key = value` what the resource tags are."
}