variable "resource_group_name" {
  type        = string
  description = "Private DNS Resource Group"
}

variable "dns_private_zone" {
  type        = string
  description = "DNS Private Zone name"
}

variable "vnet_name" {
  type        = string
  description = "VNET to be linked"
}

variable "vnet_id" {
  type        = string
  description = "VNET to be linked"
}