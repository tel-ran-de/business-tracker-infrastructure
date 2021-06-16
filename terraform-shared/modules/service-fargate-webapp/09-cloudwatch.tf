resource "aws_cloudwatch_log_group" "app" {
  name = local.cloudwatch_log_group_name
  retention_in_days = var.cloudwatch_retention_in_days
}

resource "aws_cloudwatch_log_group" "nginx" {
  name = local.cloudwatch_nginx_log_group_name
  retention_in_days = var.cloudwatch_retention_in_days
}

resource "aws_cloudwatch_log_group" "migration" {
  name = local.cloudwatch_migration_log_group_name
  retention_in_days = var.cloudwatch_retention_in_days
}

resource "aws_cloudwatch_log_group" "worker" {
  name = local.cloudwatch_worker_log_group_name
  retention_in_days = var.cloudwatch_retention_in_days
}
