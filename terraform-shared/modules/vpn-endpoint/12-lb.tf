resource "aws_alb" "vpn_backend_alb" {
  name = substr("${local.full_prefix}-backend-alb", 0, 32)
  internal = true

  security_groups = [
    aws_security_group.vpn_backend_alb_sg.id
  ]
  subnets = var.alb_subnet_ids
  idle_timeout = 60

  tags = {
    Name = "${local.full_prefix}-backend-alb"
  }
}

resource "aws_alb_target_group" "vpn_backend_tg" {
  name = substr("${local.full_prefix}-backend-tg", 0, 32)
  port = var.backend_port
  protocol = "HTTP"
  vpc_id = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold = 3
    interval = 300
    protocol = "HTTP"
    matcher = "302"
    timeout = "5"
    path = "/"
    unhealthy_threshold = 3
  }
}

resource "aws_alb_listener" "app_http" {
  load_balancer_arn = aws_alb.vpn_backend_alb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port = 443
      protocol = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "app_https" {
  load_balancer_arn = aws_alb.vpn_backend_alb.id
  port = 443
  protocol = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-2016-08"
  certificate_arn = var.ssl_certificate_arn

  default_action {
    target_group_arn = aws_alb_target_group.vpn_backend_tg.arn
    type = "forward"
  }
}
