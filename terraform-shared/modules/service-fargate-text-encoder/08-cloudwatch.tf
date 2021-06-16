resource "aws_cloudwatch_log_group" "text_encoder" {
  name = local.cloudwatch_log_group_name
  retention_in_days = var.cloudwatch_retention_in_days
}
