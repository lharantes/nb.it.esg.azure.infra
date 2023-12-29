# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - GLOBAL
# ---------------------------------------------------------------------------------------------------------------------

environment   = "dev"
location      = "northeurope"
sufix_project = "data01"
sufix_common = "nprd-common"
global_tags = {
  Environment  = "Development"
  "Created By" = "Terraform"
  "Approver"   = "Approver_Name"
}

rg_tags = {
}

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - Networks
# ---------------------------------------------------------------------------------------------------------------------

vnet_address_space = ["10.237.100.0/22"]
subnet = {
  snet-ne-data01-dev = {
    address_prefix    = ["10.237.100.0/27"]
    service_endpoints = ["Microsoft.Storage"]
  }
   snet-ne-data01-nprd-common = {
    address_prefix    = ["10.237.100.64/27"]
    service_endpoints = []
  }
}
vnet_dns_server = ["10.237.7.4"]
vnet_tags = {}
subnet_common = "snet-ne-data01-nprd-common"
subnet_env= "snet-ne-data01-dev"

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - Route Table
# ---------------------------------------------------------------------------------------------------------------------

route_table_01 = {
  rt1 = {
    route_name     = "default"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "VirtualAppliance"
    next_hop_ip    = "10.237.1.132"
  }
    rt2 = {
    route_name     = "vnet-hub"
    address_prefix = "10.237.0.0/21"
    next_hop_type  = "VirtualAppliance"
    next_hop_ip    = "10.237.1.132"
  }
}

route_table_common = {
  rt1 = {
    route_name     = "default"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "VirtualAppliance"
    next_hop_ip    = "10.237.1.132"
  }
    rt2 = {
    route_name     = "vnet-hub"
    address_prefix = "10.237.0.0/21"
    next_hop_type  = "VirtualAppliance"
    next_hop_ip    = "10.237.1.132"
  }
}

route_tags = {}

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - Networks Security Group
# ---------------------------------------------------------------------------------------------------------------------

nsgrules = {
  /*  rdp = {
    name                       = "rdp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }
  */
}

nsgrules_common = {
  /*  rdp = {
    name                       = "rdp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }
  */
}

nsg_tags = {
}

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - Storage Account
# ---------------------------------------------------------------------------------------------------------------------=

tier        = "Standard"
kind        = "StorageV2"
replication = "LRS"

# Para acesso somente a alguma rede virtual, deixar true nos 2 itens
public_access_enabled  = true
network_access_enabled = true

# File Share ou containers a serem criados na Storage Account
storage_shares = {}
storage_containers = {
  oracle = {
    name                  = "oracle"
    container_access_type = "container"
  }
}
storage_tags = {
}

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - Data Factory
# ---------------------------------------------------------------------------------------------------------------------

adf_tags = {
}

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - Private Endpoint - Storage Account
# ---------------------------------------------------------------------------------------------------------------------

is_manual_connection  = false
private_endpoint_name = "pep-blob-bdsodata01dev01"

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - Private Endpoint
# ---------------------------------------------------------------------------------------------------------------------

is_manual_connection_adf  = false
private_endpoint_name_adf = "pep-df-bdso-adf-data01-dev"

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - KeyVault - TFVARS
# ---------------------------------------------------------------------------------------------------------------------

kv_name = "kv-teste00000000111111"
kv_sku  = "standard"

kv_secrets = {}

keyvault_tags = {
}