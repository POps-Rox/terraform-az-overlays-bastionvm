# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

provider "azurerm" {
  features {}
}

module "mod_bastion_vm" {
  source = "../.."

  location            = "eastus"
  location_short      = "eus"
  environment         = "dev"
  workload            = "bastion"
  resource_group_name = "rg-bastion-dev"
  client_name         = "example"

  subnet_bastion_id  = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-bastion-dev/providers/Microsoft.Network/virtualNetworks/vnet-dev/subnets/snet-bastion"
  private_ip_bastion = "10.0.1.10"

  vm_size         = "Standard_B2s"
  ssh_public_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDummykey example@example.com"
  ssh_private_key = "dummy-private-key"

  storage_os_disk_size_gb = 30
  backup_policy_id        = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-bastion-dev/providers/Microsoft.RecoveryServices/vaults/rsv-dev/backupPolicies/pol-dev"
}
