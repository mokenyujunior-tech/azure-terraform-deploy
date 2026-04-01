resource "azurerm_storage_account" "app" {
  name                       = var.storage_account_name
  resource_group_name        = azurerm_resource_group.main.name
  location                   = azurerm_resource_group.main.location
  account_tier               = "Standard"
  account_replication_type   = "LRS"
  https_traffic_only_enabled = true
  min_tls_version            = "TLS1_2"
  tags = {
    environment = "learning"
    project     = "az104-terraform"
  }
}
resource "azurerm_storage_container" "data" {
  name                  = "appdata"
  storage_account_name  = azurerm_storage_account.app.name
  container_access_type = "private"
}