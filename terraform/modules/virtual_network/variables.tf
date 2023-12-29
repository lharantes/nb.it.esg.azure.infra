variable "resource_group_name" {
  type        = string
  description = "Virtual Network Resource Group"
}

variable "vnet_name" {
  type        = string
  description = "Virtual Network name"
}

variable "address_space" {
  type        = list(any)
  description = "Virtual Network Address Space, ex: ['10.200.0.0/16']"
}

variable "dns_servers" {
  type        = list(any)
  description = "Virtual Network DNS Server"
  default     = []
}

variable "subnet" {
  type = map(object({
    address_prefix    = list(string)
    service_endpoints = list(string)
  }))
  description = "Subnets for Virtual Network"
}

variable "vnet_tags" {
  type        = map(any)
  default     = {}
  description = "Character map identifying through `key = value` what the resource tags are."
}