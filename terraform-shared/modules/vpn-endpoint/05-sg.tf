resource aws_security_group "vpn_endpoint_sg" {
  name = "${local.full_prefix}-endpoint-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port = 443
    protocol = "UDP"
    to_port = 443
    cidr_blocks = [
      "0.0.0.0/0"]
    description = "Incoming VPN connection"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  tags = {
    Name = "${local.full_prefix}-endpoint-sg"
  }
}

resource aws_security_group "vpn_backend_alb_sg" {
  name = "${local.full_prefix}-backend-alb-sg"
  description = "Allow VPC inbound traffic"
  vpc_id = var.vpc_id

  ingress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    security_groups = [aws_security_group.vpn_endpoint_sg.id]
  }
  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = [
      "0.0.0.0/0"]
    ipv6_cidr_blocks = [
      "::/0"]
  }

  tags = {
    Name = "${local.full_prefix}-backend-alb-sg"
  }
}
