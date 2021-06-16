resource "aws_ec2_client_vpn_endpoint" "vpn_endpoint" {
  description = "${var.prefix}-vpn-endpoint"
  server_certificate_arn = var.server_cert_arn
  client_cidr_block = var.client_cidr_block
  split_tunnel = var.is_split_tunnel
  dns_servers = var.dns_servers

  authentication_options {
    type = "certificate-authentication"
    root_certificate_chain_arn = var.client_cert_arn
  }

  connection_log_options {
    enabled = true
    cloudwatch_log_group = aws_cloudwatch_log_group.vpn_endpoint_log_group.name
  }

  tags = {
    Name = "${var.prefix}-vpn-endpoint"
  }

  lifecycle {
    ignore_changes = [
      connection_log_options
    ]
  }
}

resource "aws_ec2_client_vpn_network_association" "vpn_endpoint_network_association" {
  count = length(var.vpn_subnet_ids)
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn_endpoint.id
  subnet_id = var.vpn_subnet_ids[count.index]

  security_groups = [
    aws_security_group.vpn_endpoint_sg.id]
}

resource "aws_ec2_client_vpn_authorization_rule" "vpn_endpoint_authorization" {
  description = "${var.prefix}-vpn-endpoint"
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn_endpoint.id
  target_network_cidr = var.vpc_cidr
  authorize_all_groups = true
}
