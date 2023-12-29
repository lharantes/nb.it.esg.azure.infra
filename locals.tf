locals {
  regions = {
    northeurope = "ne"
    eastus      = "eus"
  }
  dns_private_endpoint = {
    blob        = "privatelink.blob.core.windows.net"
    dataFactory = "privatelink.datafactory.azure.net"
  }
}