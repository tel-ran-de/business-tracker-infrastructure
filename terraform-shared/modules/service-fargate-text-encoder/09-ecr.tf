module "ecr" {
  source = "../base-ecr"
  prefix = var.prefix
  name = var.service_name
}

output "text_encoder_ecr_arn" {
  value = module.ecr.arn
}

output "text_encoder_ecr_id" {
  value = module.ecr.registry_id
}

output "text_encoder_ecr_url" {
  value = module.ecr.repository_url
}
