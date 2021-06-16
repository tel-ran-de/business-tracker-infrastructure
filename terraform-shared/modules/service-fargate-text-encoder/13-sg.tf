resource "aws_security_group" "private_lb" {
  name = "${local.full_prefix}-private-lb-sg"
  description = "Allow VPC inbound traffic"
  vpc_id = var.vpc_id

  ingress {
    protocol = "tcp"
    from_port = 0
    to_port = 65535
    security_groups = var.lb_security_groups
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
    Name = "${local.full_prefix}-private-lb-sg"
  }
}

resource "aws_security_group" "text_encoder" {
  name = "${local.full_prefix}-ecs-sg"
  description = "Internal text encoder sg"
  vpc_id = var.vpc_id

  ingress {
    protocol = "tcp"
    from_port = var.text_encoder_container_port
    to_port = var.text_encoder_container_port
    security_groups = [
      aws_security_group.private_lb.id]
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
    Name = "${local.full_prefix}-ecs-sg"
  }
}
