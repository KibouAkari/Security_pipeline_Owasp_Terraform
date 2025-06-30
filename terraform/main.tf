data "azurerm_resource_group" "existing" {
  name = var.resource_group_name
}

resource "random_id" "dns" {
  byte_length = 4
}

resource "azurerm_container_group" "juice_shop" {
  name                = "juice-shop-container"
  location            = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name
  ip_address_type     = "Public"
  dns_name_label      = "juice-shop-${random_id.dns.hex}"
  os_type             = "Linux"

  identity {
    type = "SystemAssigned"
  }

  container {
    name   = "juice-shop"
    image  = "juiceshopregistryforterraform.azurecr.io/juice-shop:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 3000
      protocol = "TCP"
    }
  }

  tags = {
    environment = "dev"
  }
}

output "fqdn" {
  value = azurerm_container_group.juice_shop.fqdn
}
