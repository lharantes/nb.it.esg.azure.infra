variable "storage_name" {
  type        = string
  description = "Storage Account name"
}

variable "resource_group_name" {
  type        = string
  description = "Storage Account Resource Group"
}

variable "location" {
  type        = string
  description = "Storage Account location"
}

variable "tier" {
  type        = string
  description = "Storage Account performance tier"
  validation {
    condition     = can(regex("Standard|Premium", var.tier))
    error_message = "Values allowed as tier: Premium or Standard."
  }
}

variable "kind" {
  type        = string
  description = "Storage Account kind"
  validation {
    condition     = can(regex("BlobStorage|BlockBlobStorage|FileStorage|Storage|StorageV2", var.kind))
    error_message = "Values allowed as Account kind: BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2."
  }
}

variable "replication" {
  type        = string
  default     = "LRS"
  description = "Storage Account replication type."
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Character map identifying through `key = value` what the resource tags are."
}

variable "subnet_allowed" {
  description = "A list of subnet ids to secure the storage account."
}

variable "vnet_storage" {
  description = "A list of virtual network to secure the storage account."
}

variable "public_access_enabled" {
  type        = bool
  description = "Whether the public network access is enabled"
}

variable "network_access_enabled" {
  type        = bool
  description = "Restrict to use a Virtual Network to access the Storage Account"
}

variable "storage_shares" {
  type        = map(any)
  description = "Create a File Share inside storage account"
}

variable "storage_containers" {
  type = map(object({
    name                  = string
    container_access_type = string
  }))
  description = "Create a container inside storage account"
}
/*
variable "container_access_type" {
  type = string
  validation {
    condition     = can(regex("blob|container|private", var.container_access_type))
    error_message = "Selecione apenas um dos valores aceitos como tipo de Acesso: blob, container ou private."
  }
}
*/