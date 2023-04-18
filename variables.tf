variable "names" {
  description = "ECR repo names"
  type        = list(any)
}

variable "max_images_retained" {
  description = "The max number of images to keep in the repository before expiring the oldest"
  type        = number
  default     = 100
}

variable "trusted_accounts" {
  description = "IDs of other accounts that are trusted to these repositories"
  type        = list(any)
  default     = []
}

variable "tags" {
  description = "A map of tags (key-value pairs) passed to resources."
  type        = map(any)
  default     = {}
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository"
  type        = bool
  default     = true
}

variable "enable_scan_on_push" {
  description = "Enable vulnerability scanning on image push"
  type        = bool
  default     = true
}

variable "actions" {
  description = "IAM policy actions"
  type        = list(any)
  default = [
    "ecr:BatchCheckLayerAvailability",
    "ecr:BatchGetImage",
    "ecr:GetAuthorizationToken",
    "ecr:GetDownloadUrlForLayer"
  ]
}

variable "custom_policy_json" {
  description = "Custom policy created from aws_iam_policy_document json to apply to repos"
  default     = null
}
