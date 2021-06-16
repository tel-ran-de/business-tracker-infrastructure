output "arn" {
  value = aws_ecr_repository.base.arn
}

output "registry_id" {
  value = aws_ecr_repository.base.registry_id
}

output "repository_url" {
  value = aws_ecr_repository.base.repository_url
}
