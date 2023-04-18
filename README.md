# Terraform AWS ECR repo module

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Description](#description)
- [Example](#example)
- [Requirements](#requirements)
- [Providers](#providers)
- [Modules](#modules)
- [Resources](#resources)
- [Inputs](#inputs)
- [Outputs](#outputs)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Description
- Creates a repository on ECR
- Creates a policy to allow other accounts push and pull access
- Creates a lifecycle policy that expires oldest images when a specified limit is reached
- Enable/Disable vulnerability scan on image push


## Example
```hcl
locals {
  ecr_repos = [
    "docker-base-yii",
    "docker-yii-mockup",
  ]
}

module "ecr" {
  source = "terraform-aws-ecr"

  names               = local.ecr_repos
  max_images_retained = 500
  tags                = module.tags.tags

  trusted_accounts = [
    local.aws_accounts["ops"],
    local.aws_accounts["test"],
    local.aws_accounts["stage"],
    local.aws_accounts["prod"]
  ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_lifecycle_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_actions"></a> [actions](#input\_actions) | IAM policy actions | `list(any)` | <pre>[<br>  "ecr:BatchCheckLayerAvailability",<br>  "ecr:BatchGetImage",<br>  "ecr:GetAuthorizationToken",<br>  "ecr:GetDownloadUrlForLayer"<br>]</pre> | no |
| <a name="input_custom_policy_json"></a> [custom\_policy\_json](#input\_custom\_policy\_json) | Custom policy created from aws\_iam\_policy\_document json to apply to repos | `any` | `null` | no |
| <a name="input_enable_scan_on_push"></a> [enable\_scan\_on\_push](#input\_enable\_scan\_on\_push) | Enable vulnerability scanning on image push | `bool` | `true` | no |
| <a name="input_image_tag_mutability"></a> [image\_tag\_mutability](#input\_image\_tag\_mutability) | The tag mutability setting for the repository | `bool` | `true` | no |
| <a name="input_max_images_retained"></a> [max\_images\_retained](#input\_max\_images\_retained) | The max number of images to keep in the repository before expiring the oldest | `number` | `100` | no |
| <a name="input_names"></a> [names](#input\_names) | ECR repo names | `list(any)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags (key-value pairs) passed to resources. | `map(any)` | `{}` | no |
| <a name="input_trusted_accounts"></a> [trusted\_accounts](#input\_trusted\_accounts) | IDs of other accounts that are trusted to these repositories | `list(any)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_repos"></a> [repos](#output\_repos) | Map of the ECR repositories |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
