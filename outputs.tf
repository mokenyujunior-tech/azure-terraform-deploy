output "resource_group_name" {
  value       = azurerm_resource_group.main.name
  description = "The name of the deployed resource group"
}
output "vm_public_ip" {
  value       = azurerm_public_ip.main.ip_address
  description = "Public IP — use this to connect to the VM"
}
output "vm_name" {
  value       = azurerm_linux_virtual_machine.main.name
  description = "Name of the deployed virtual machine"
}
output "storage_account_name" {
  value       = azurerm_storage_account.app.name
  description = "Name of the deployed storage account"
}
output "log_workspace_id" {
  value       = azurerm_log_analytics_workspace.main.id
  description = "ID of the Log Analytics Workspace"
}