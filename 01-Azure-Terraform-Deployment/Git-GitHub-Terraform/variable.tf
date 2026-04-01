variable "resource_group_name" {
  description = "Name of the main resource group"
  type        = string
  default     = "az104-terraform-rg"
}
variable "location" {
  description = "Azure region for all resources"
  type        = string
  default     = "canadacentral"
}
variable "vnet_address_space" {
  description = "CIDR address space for the VNet"
  type        = string
  default     = "10.0.0.0/16"
}
variable "subnet_prefix" {
  description = "CIDR prefix for the main subnet"
  type        = string
  default     = "10.0.1.0/24"
}
variable "vm_size" {
  description = "Size of the Virtual Machine"
  type        = string
  default     = "Standard_D2s_v3"
}
variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "azureadmin"
}
variable "admin_password" {
  description = "Admin password — passed from GitHub Secrets, never hardcoded"
  type        = string
  sensitive   = true
}
variable "storage_account_name" {
  description = "Globally unique name for the app storage account"
  type        = string
  default     = "mkappstorage2026"
}