variable "adf_name" {
  type        = string
  description = "Azure Data Factory name"
}

variable "resource_group_name" {
  type        = string
  description = "Azure Data Factory Resource Group"
}

variable "rg_location" {
  type        = string
  description = "Azure Data Factory location"
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Character map identifying through `key = value` what the resource tags are."
}