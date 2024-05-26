resource "azurerm_resource_group" "resource" {
    for_each = var.k8s
  name     = each.value.resource_group_name
  location = each.value.location
}

resource "azurerm_kubernetes_cluster" "example" {
    for_each = var.k8s
  name                = each.value.name
  location            = azurerm_resource_group.resource[each.key].location
  resource_group_name = azurerm_resource_group.resource[each.key].name
  dns_prefix          = "exampleaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  
}

# output "client_certificate" {
#   value     = azurerm_kubernetes_cluster.example.kube_config[0].client_certificate
#   sensitive = true
# }

# output "kube_config" {
#   value = azurerm_kubernetes_cluster.example.kube_config_raw

#   sensitive = true
# }