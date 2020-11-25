# Terraform AWS ECR repo module

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [Description](#description)
- [Example](#example)
- [Requirements](#requirements)
- [Providers](#providers)
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
  source = "git@github.com:basefarm/terraform-aws-ecr?ref=v0.1.0"

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
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| actions | IAM policy actions | `list` | <pre>[<br>  "ecr:BatchCheckLayerAvailability",<br>  "ecr:BatchGetImage",<br>  "ecr:GetAuthorizationToken",<br>  "ecr:GetDownloadUrlForLayer"<br>]</pre> | no |
| custom\_policy\_json | Custom policy created from aws\_iam\_policy\_document json to apply to repos | `any` | `null` | no |
| enable\_scan\_on\_push | Enable vulnerability scanning on image push | `bool` | `true` | no |
| image\_tag\_mutability | The tag mutability setting for the repository | `bool` | `true` | no |
| max\_images\_retained | The max number of images to keep in the repository before expiring the oldest | `number` | `100` | no |
| names | ECR repo names | `list` | n/a | yes |
| tags | A map of tags (key-value pairs) passed to resources. | `map` | `{}` | no |
| trusted\_accounts | IDs of other accounts that are trusted to these repositories | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| repos | Map of the ECR repositories |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
