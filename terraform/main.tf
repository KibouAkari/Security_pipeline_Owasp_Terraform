resource "azurerm_resource_group" "rg" {
  name     = "nicolas-test"
  location = var.location
  tags = {
    created_by    = "nicolas"
    creation_date = "12.06.25"
  }
}

resource "azurerm_container_registry" "acr" {
  name                = "nicolasContainerRegistry8726422"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
  tags = {
    created_by    = "nicolas"
    creation_date = "12.06.25"
  }
}

resource "azurerm_container_group" "continst" {
  name = "nicolas-continst"
  location = var.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type = "Public"
  dns_name_label = "aci-label"
  os_type = "Linux"
  container {
    name = "nicolas-container"
    
    image = "https://hub.docker.com/r/bkimminich/juice-shop:latest"
    cpu = "0.5"
    memory = "1.5"
    ports {
      port = 3000
      protocol = "TCP"
    }

  }

  tags = {
    environment = "nicolas-testing"
  }

}