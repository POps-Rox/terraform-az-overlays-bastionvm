mock_provider "azurerm" {}
mock_provider "azapi" {}
mock_provider "popsrox" {}
mock_provider "azurecaf" {
  mock_data "azurecaf_name" {
    defaults = {
      result = "bastion-example-eus-dev"
    }
  }
}

variables {
  location                = "eastus"
  location_short          = "eus"
  environment             = "dev"
  workload                = "bastion"
  resource_group_name     = "rg-bastion-dev"
  client_name             = "example"
  subnet_bastion_id       = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-bastion-dev/providers/Microsoft.Network/virtualNetworks/vnet-dev/subnets/snet-bastion"
  private_ip_bastion      = "10.0.1.10"
  vm_size                 = "Standard_B2s"
  ssh_public_key          = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDummykey example@example.com"
  ssh_private_key         = "dummy-private-key"
  storage_os_disk_size_gb = "30"
  backup_policy_id        = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-bastion-dev/providers/Microsoft.RecoveryServices/vaults/rsv-dev/backupPolicies/pol-dev"
}

run "custom_hostname_override_takes_precedence" {
  command = plan

  variables {
    custom_vm_hostname = "custom-bastion-host"
  }

  assert {
    condition     = output.bastion_hostname == "custom-bastion-host"
    error_message = "custom_vm_hostname must take precedence over the generated CAF hostname."
  }
}

run "generated_hostname_falls_through_empty_custom_name" {
  command = plan

  variables {
    custom_vm_hostname = ""
  }

  assert {
    condition     = output.bastion_hostname == "bastion-example-eus-dev"
    error_message = "An empty custom_vm_hostname must fall through to the generated CAF hostname."
  }
}

run "default_tags_are_enabled_and_populated" {
  command = plan

  assert {
    condition     = length(keys(local.default_tags)) == 3 && local.default_tags.deployedBy == "AzureNoOpsTF [default]" && local.default_tags.environment == "dev" && local.default_tags.workload == "bastion"
    error_message = "Default tags must include deployment, environment, and workload values when enabled."
  }
}

run "default_tags_can_be_disabled" {
  command = plan

  variables {
    default_tags_enabled = false
  }

  assert {
    condition     = length(keys(local.default_tags)) == 0
    error_message = "default_tags_enabled=false must suppress all default tags."
  }
}

run "location_and_vm_inputs_pass_through" {
  command = plan

  assert {
    condition     = var.location == "eastus"
    error_message = "The module must preserve the caller-provided location."
  }

  assert {
    condition     = output.bastion_virtual_machine_size == "Standard_B2s"
    error_message = "The VM size output must pass through the caller-provided vm_size."
  }

  assert {
    condition     = output.bastion_admin_username == "anoa"
    error_message = "The admin username output must preserve the module default."
  }
}
