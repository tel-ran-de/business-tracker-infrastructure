locals { ecr_version = "202105241107" }

locals {
  app_ecr_name = "${var.name}-${local.ecr_version}"
  nginx_ecr_name = "${var.name}-nginx-${local.ecr_version}"
}

################################ APP ################################

module "app_ecr" {
  source = "../base-ecr"
  prefix = var.prefix # abcdoc-v2-staging
  name = local.app_ecr_name
}

output "app_ecr_arn" { value = module.app_ecr.arn }
output "app_ecr_id"  { value = module.app_ecr.registry_id }
output "app_ecr_url" { value = module.app_ecr.repository_url }

################################ NGINX ################################

module "nginx_ecr" {
  source = "../base-ecr"
  prefix = var.prefix
  name = local.nginx_ecr_name
}

output "nginx_ecr_arn" { value = module.nginx_ecr.arn }
output "nginx_ecr_id"  { value = module.nginx_ecr.registry_id }
output "nginx_ecr_url" { value = module.nginx_ecr.repository_url }
