resource "azurerm_resource_group" "rg" {
  name     = "juice-shop-rg"
  location = var.location

  tags = {
    created_by    = "KibouAkari"
    creation_date = "25.06.25"
  }
}

resource "random_id" "dns" {
  byte_length = 4
}

resource "azurerm_container_group" "juice_shop" {
  name                = "juice-shop-container"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "Public"
  dns_name_label      = "juice-shop-${random_id.dns.hex}"
  os_type             = "Linux"

  container {
    name   = "juice-shop"
    image  = "bkimminich/juice-shop:latest"
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
