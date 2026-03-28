# Azure Infrastructure Deployment — Terraform & GitHub Actions

Every resource in this project is defined in code, version-controlled, and deployed automatically. No portal clicking, no manual configuration. Terraform handles the Infrastructure as Code, a GitHub Actions pipeline handles the automation, and PowerShell drives every command from local development to the pipeline runner. The result is a repeatable, production-pattern Azure environment that maps directly across some Microsoft Azure Administrator learning paths.

---

## Architecture

---
![Architecture](https://github.com/user-attachments/assets/df3d3b47-4c2f-4d6f-9794-e029b20ffd18)

---

---

## What This Project Covers

- Infrastructure as Code design and implementation
- CI/CD pipeline creation and automation
- Azure identity and access management (RBAC, Service Principal)
- Virtual network design — VNet, Subnet, NSG rule prioritisation
- Cloud storage configuration and security hardening
- Virtual machine provisioning and SSH access
- Infrastructure monitoring and alerting with Azure Monitor
- Secret management using GitHub Secrets
- Git version control and branching workflow

---

## What Was Built

- Wrote Terraform configuration files defining all Azure resources.
- Configured a GitHub Actions CI/CD pipeline with Validate, Plan, and Apply jobs.
- Created an Azure Service Principal with Contributor RBAC role for automated authentication.
- Set up remote Terraform state storage in Azure Blob Storage.
- Deployed a Virtual Network with subnets and Network Security Group rules.
- Provisioned a Linux Virtual Machine connected to the network via NIC and Public IP.
- Configured a Storage Account with HTTPS-only and TLS 1.2 enforced.
- Set up a Log Analytics Workspace and Azure Monitor CPU alert.
- Managed all secrets securely through GitHub Secrets, never hardcoded.
- Used PowerShell exclusively for all local commands and pipeline jobs.

---
## Troubleshooting
### Terraform Remote State Backend Lost (404 Not Found)
- During setup I created the Terraform remote state storage account with a different name to the one referenced in main.tf. When I ran terraform init, it returned a 404 ResourceNotFound error because Terraform could not lovate the backend stroage account. I then updated the storage_account_name value in the backend "azurerm" block inside mainl.tf to match the name I had created in Azure, then reran terraform init successfully.
### Secrets Exposed in Version Control (terraform.tfvars staged to Git)
- Before committing, I ran "git add ." without first checking "git status". When I ran "git status" afterwards I noticed "terraform.tfvars" was staged(a file containing sensitive values). It was mising from ".gitignore". meaning Git was tracking it and it would have been pushed to the pubic repository. I immediately ran "git rm --cached terraform.tfvars" to unstage it without deleting the local file, then added it to .gitignore.
### Service Principal Authentication Failure in CI/CD Pipeline
- Github actions passes service principal credentials to Terraform via PowerShell environment variable rather than a command-line flag/option. I used "-var flag" instaead of "$env:TF_VAR_ADMIN_PASSWORD" syntax which was repeatedly cause the Terraform Plan job to fail. So, the fix was to use the syntax $env:TF_VAR_ADMIN_PASSWORD.
---
## Stack

- Terraform (Infrastructure as Code)
- GitHub Actions (CI/CD pipeline)
- PowerShell 7
- Microsoft Azure
- Azure CLI
- AzureRM Terraform Provider v3.100
- IAM (Service Principal)
- Azure Blob Storage (remote state backend)

---

## Resources Deployed

| # | Resource | Name | Description |
|---|---|---|---|
| 1 | Resource Group | `az104-terraform-rg` | Container holding all resources in Canada Central |
| 2 | Virtual Network | `az104-vnet` | Private isolated network - 10.0.0.0/16 address space |
| 3 | Subnet | `main-subnet` | Subdivides the VNet - 10.0.1.0/24 prefix |
| 4 | Network Security Group | `az104-nsg` | Inbound rules: allow RDP (3389), SSH (22), deny all else |
| 5 | Public IP Address | `az104-public-ip` | Static Standard SKU IP for external VM access |
| 6 | Network Interface | `az104-nic` | Links the VM to the subnet and Public IP |
| 7 | Linux Virtual Machine | `az104-linux-vm` | Ubuntu 20.04 LTS - Standard_D2s_v3 - admin: azureadmin |
| 8 | Storage Account | `mkappstorage2026` | Standard LRS - HTTPS only - TLS 1.2 enforced |
| 9 | Blob Container | `appdata` | Private access only - no anonymous reads permitted |
| 10 | Log Analytics Workspace | `az104-log-workspace` | Ingests VM metrics and logs - 30-day retention |
| 11 | Azure Monitor Alert | `az104-cpu-high-alert` | Email alert fires when CPU exceeds 80% for 15 minutes |

---
