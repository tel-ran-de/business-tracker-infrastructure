resource "aws_cloudwatch_log_group" "fargate_service" {
  name = local.cloudwatch_log_group_name
  retention_in_days = var.cloudwatch_retention_in_days
}
