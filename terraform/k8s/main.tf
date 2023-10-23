provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "myResourceGroup"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "myAKSCluster"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "myaksdns"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "example" {
  name                = "pool1"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.example.id
  vm_size             = "Standard_DS2_v2"
  node_count          = 1
  enable_auto_scaling = true
  min_count           = 1
  max_count           = 3
}