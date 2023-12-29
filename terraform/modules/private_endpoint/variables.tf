variable "resource_group_name" {
  type        = string
  description = "Resource Group name"
}

variable "location" {
  type        = string
  description = "Resource Group location"
}

variable "vnet_id" {
  type        = string
  description = "VNET ID where the private endpoint will be created"
}

variable "subnet_allowed" {
  type        = string
  description = "Subnet allowed"
}

variable "dns_private_zone" {
  type        = string
  description = "Which Private Zone will be used by the private endpoint"
}

variable "subresource_names" {
  type        = list(any)
  description = "Resources of private endpoint"
}

variable "is_manual_connection" {
  type        = bool
  description = "Manual connection for the private endpoint"
}

variable "resource_id" {
  type        = string
  description = "Resources of private endpoint"
}

variable "private_endpoint_name" {
  type        = string
  description = "Private endpoint name"
}