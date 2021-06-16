resource "aws_security_group" "lb" {
  name        = "${local.prefix}-public-lb-sg"
  description = "Allow HTTP & HTTPs inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    protocol  = "tcp"
    from_port = 443
    to_port   = 443
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    protocol  = "-1"
    from_port = 0
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${local.prefix}-public-lb-sg"
  }
}

resource "aws_security_group" "app" {
  name        = "${local.prefix}-app-sg"
  description = "Internal app sg"
  vpc_id      = var.vpc_id

  ingress {
    protocol  = "tcp"
    from_port = var.nginx_container_port
    to_port   = var.nginx_container_port
    security_groups = concat( [
      aws_security_group.lb.id], var.extra_security_group_ids)
  }

  egress {
    protocol  = "-1"
    from_port = 0
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${local.prefix}-app-ecs-sg"
  }
}
