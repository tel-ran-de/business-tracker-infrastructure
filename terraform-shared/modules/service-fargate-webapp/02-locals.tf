locals {
  prefix = "${var.prefix}-${var.name}"
}

locals {
  cloudwatch_log_group_name = "/ecs/${local.prefix}-app"
  cloudwatch_nginx_log_group_name = "/ecs/${local.prefix}-nginx"
  cloudwatch_worker_log_group_name = "/ecs/${local.prefix}-worker"
  cloudwatch_migration_log_group_name = "/ecs/${local.prefix}-migration"

  app_container_name = "${local.prefix}-app"
  nginx_container_name = "${local.prefix}-nginx"
  migration_container_name = "${local.prefix}-migration"
  worker_container_name = "${local.prefix}-worker"
}
