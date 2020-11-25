output "repos" {
  description = "Map of the ECR repositories"
  value       = aws_ecr_repository.this
}
