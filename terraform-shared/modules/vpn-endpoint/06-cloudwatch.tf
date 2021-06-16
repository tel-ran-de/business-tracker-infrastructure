resource "aws_cloudwatch_log_group" "vpn_endpoint_log_group" {
  name = "${var.prefix}-vpn-endpoint"
  retention_in_days = var.cloudwatch_retention_in_days
}
