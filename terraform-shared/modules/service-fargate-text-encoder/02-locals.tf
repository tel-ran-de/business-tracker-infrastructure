locals {
  full_prefix = "${var.prefix}-${var.service_name}"
  cloudwatch_log_group_name = "/ecs/${local.full_prefix}"
}
