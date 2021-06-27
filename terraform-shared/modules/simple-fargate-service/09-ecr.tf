module "ecr" {
  source = "../base-ecr"
  prefix = var.prefix
  name = var.service_name
}

output "fargate_service_ecr_arn" {
  value = module.ecr.arn
}

output "fargate_service_ecr_id" {
  value = module.ecr.registry_id
}

output "fargate_service_ecr_url" {
  value = module.ecr.repository_url
}
