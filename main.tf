resource "aws_ecr_repository" "this" {
  for_each = toset(var.names)

  name                 = each.value
  image_tag_mutability = var.image_tag_mutability ? "MUTABLE" : "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = var.enable_scan_on_push
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = var.tags
}

resource "aws_ecr_repository_policy" "this" {
  for_each   = aws_ecr_repository.this
  repository = each.value.id
  policy     = var.custom_policy_json != null ? var.custom_policy_json : data.aws_iam_policy_document.this.json
}

data "aws_iam_policy_document" "this" {

  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = formatlist("arn:aws:iam::%s:root", var.trusted_accounts)
    }

    actions = var.actions
  }
}

resource "aws_ecr_lifecycle_policy" "this" {
  for_each   = aws_ecr_repository.this
  repository = each.value.id

  policy = <<EOF
{
  "rules": [{
    "rulePriority": 1,
    "description": "Expire all but ${var.max_images_retained} latest images (terraformed)",
    "selection": {
      "tagStatus": "any",
      "countType": "imageCountMoreThan",
      "countNumber": ${var.max_images_retained}
    },
    "action": {
      "type": "expire"
    }
  }]
}
EOF
}
