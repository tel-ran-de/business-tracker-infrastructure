module "db" {
  # count = 0

  name = "base"
  source = "../terraform-shared/modules/base-db"
  prefix = local.prefix
  stage  = var.stage
  aws_region = var.aws_region

  vpc_id = module.vpc.vpc_id
  subnet_ids = [module.vpc.private_subnets.0, module.vpc.private_subnets.1]
  dns_zone_id = aws_route53_zone.internal.id

  db_name = "abcdoc_${var.stage}" # rails convention, eg: abcdoc_production

  SECRET_db_username = var.SECRET_base_db_username
  SECRET_db_password = var.SECRET_base_db_password

  db_storage_size = var.base_db_storage_size
  db_engine_version = var.base_db_engine_version
  db_instance = var.base_db_instance
  db_maintenance_window = var.base_db_maintenance_window
  db_backup_window = var.base_db_backup_window
  db_backup_retention_period = var.base_db_backup_retention_period
}
