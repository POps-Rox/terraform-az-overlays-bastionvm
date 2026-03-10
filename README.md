<!-- BADGES:START -->
[![CI](https://github.com/POps-Rox/tf-az-overlays-bastionvm/actions/workflows/ci.yml/badge.svg)](https://github.com/POps-Rox/tf-az-overlays-bastionvm/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/POps-Rox/tf-az-overlays-bastionvm/pulls)
[![Maintained](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/POps-Rox/tf-az-overlays-bastionvm/graphs/commit-activity)
[![Terraform](https://img.shields.io/badge/Terraform-%3E%3D1.5-623CE4.svg?logo=terraform)](https://www.terraform.io)
<!-- BADGES:END -->

# Microsoft Verified Terraform Module

The Verified Terraform module is a template repository to help developers create their own Terraform Module.

As we've used Microsoft 1ES Runners Pool as our acceptance test runner, **only Microsoft members could use this template for now**.

Enjoy it by following steps:

1. Use [this template](https://github.com/Azure/terraform-verified-module) to create your repository.
2. Read [Onboard 1ES hosted Github Runners Pool through Azure Portal](https://eng.ms/docs/cloud-ai-platform/devdiv/one-engineering-system-1es/1es-docs/1es-github-runners/createpoolportal), install [1ES Resource Management](https://github.com/apps/1es-resource-management) on your repo.
3. Add a Github [Environment](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment) named **acctests** in your repo, setup [**Required Reviewers**](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment#required-reviewers).
4. Update [`acc-test.yaml`](.github/workflows/acc-test.yaml), modify `runs-on: [self-hosted, 1ES.Pool=<YOUR_REPO_NAME>]` with your 1es runners' pool name (basically it's your repo's name).
5. Write Terraform code in a new branch.
6. Run `docker run --rm -v ${pwd}:/src -w /src mcr.microsoft.com/azterraform:latest make pre-commit` to format the code.
7. Run `docker run --rm -v $(pwd):/src -w /src mcr.microsoft.com/azterraform:latest make pr-check` to run the check in local.
8. Create a pull request for the main branch.
    * CI pr-check will be executed automatically.
    * Once pr-check was passed, with manually approval, the e2e test and version upgrade test would be executed.
9. Merge pull request.
10. Enjoy it!

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name                                                                      | Version |
|---------------------------------------------------------------------------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1  |
| <a name="requirement_null"></a> [null](#requirement\_null)                | >= 3.1  |

## Providers

| Name                                                 | Version |
|------------------------------------------------------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | >= 3.1  |

## Modules

No modules.

## Resources

| Name                                                                                                       | Type     |
|------------------------------------------------------------------------------------------------------------|----------|
| [null_resource.nop](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name                                                            | Description      | Type     | Default | Required |
|-----------------------------------------------------------------|------------------|----------|---------|:--------:|
| <a name="input_echo_text"></a> [echo\_text](#input\_echo\_text) | The text to echo | `string` | n/a     |   yes    |

## Outputs

| Name                                                              | Description      |
|-------------------------------------------------------------------|------------------|
| <a name="output_echo_text"></a> [echo\_text](#output\_echo\_text) | The text to echo |
<!-- END_TF_DOCS -->
