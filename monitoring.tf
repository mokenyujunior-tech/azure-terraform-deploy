resource "azurerm_log_analytics_workspace" "main" {
  name                = "az104-log-workspace"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
resource "azurerm_monitor_action_group" "email_alert" {
  name                = "az104-email-alerts"
  resource_group_name = azurerm_resource_group.main.name
  short_name          = "emailalert"
  email_receiver {
    name          = "Admin's Email"
    email_address = "hojohn8225@gmail.com"
  }
}
resource "azurerm_monitor_metric_alert" "cpu_alert" {
  name                = "az104-cpu-high-alert"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_linux_virtual_machine.main.id]
  description         = "Alert when CPU exceeds 80 percent"
  severity            = 2
  frequency           = "PT5M"
  window_size         = "PT15M"
  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }
  action {
    action_group_id = azurerm_monitor_action_group.email_alert.id
  }
}