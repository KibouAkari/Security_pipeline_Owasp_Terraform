
# Versuche, die RG zu lesen (wenn sie existiert)
data "azurerm_resource_group" "existing" {
  name  = var.resource_group_name
  count = 1
}

# Erstelle die RG nur, wenn sie nicht existiert
resource "azurerm_resource_group" "rg" {
  count    = length(data.azurerm_resource_group.existing) == 0 ? 1 : 0
  name     = var.resource_group_name
  location = var.location

  tags = {
    created_by    = "KibouAkari"
    creation_date = "27.06.25"
  }
}

# Wähle die RG dynamisch aus
locals {
  rg_name     = length(data.azurerm_resource_group.existing) > 0 ? data.azurerm_resource_group.existing[0].name : azurerm_resource_group.rg[0].name
  rg_location = length(data.azurerm_resource_group.existing) > 0 ? data.azurerm_resource_group.existing[0].location : azurerm_resource_group.rg[0].location
}

resource "random_id" "dns" {
  byte_length = 4
}

resource "azurerm_container_group" "juice_shop" {
  name                = "juice-shop-container"
  location            = local.rg_location
  resource_group_name = local.rg_name
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
