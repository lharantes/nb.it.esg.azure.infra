variable "nsg_name" {
  type        = string
  description = "Network Security Group name"
}

variable "rg_name" {
  description = "Route table Resource Group"
}

variable "rg_location" {
  description = "Route table location"
}

variable "nsgrules" {
  type        = map(any)
  description = "Network Security Group Rules "
}

variable "subnet_id" {
  type        = string
  description = "Subnet associated to Route table"
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Character map identifying through `key = value` what the resource tags are."
}