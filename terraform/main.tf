resource "null_resource" "delete_rg" {
  provisioner "local-exec" {
    command = <<EOT
      echo "Deleting existing resource group (if it exists)..."
      az group delete --name juice-shop-rg --yes --no-wait || echo "Resource group not found or already deleted"
      echo "Waiting 30 seconds to ensure deletion..."
      sleep 30
    EOT
  }

  triggers = {
    always_run = timestamp()
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "juice-shop-rg"
  location = var.location

  tags = {
    created_by    = "KibouAkari"
    creation_date = "27.06.25"
  }

  depends_on = [null_resource.delete_rg]
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
