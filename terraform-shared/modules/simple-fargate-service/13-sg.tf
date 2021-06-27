resource "aws_security_group" "public_lb" {
  name = "${local.full_prefix}-public-lb-sg"
  description = "Allow HTTP & HTTPs inbound traffic"
  vpc_id = var.vpc_id

  ingress {
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = [
      "0.0.0.0/0"]
    ipv6_cidr_blocks = [
      "::/0"]
  }

  ingress {
    protocol = "tcp"
    from_port = 443
    to_port = 443
    cidr_blocks = [
      "0.0.0.0/0"]
    ipv6_cidr_blocks = [
      "::/0"]
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
    Name = "${local.full_prefix}-public-lb-sg"
  }
}

resource "aws_security_group" "fargate_service" {
  name = "${local.full_prefix}-ecs-sg"
  vpc_id = var.vpc_id

  ingress {
    protocol = "tcp"
    from_port = var.fargate_service_container_port
    to_port = var.fargate_service_container_port
    security_groups = concat( [
      aws_security_group.public_lb.id], var.extra_fargate_service_security_group_ids)
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
