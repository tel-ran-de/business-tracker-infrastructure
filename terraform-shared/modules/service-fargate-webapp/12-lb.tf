resource "aws_alb" "app" {
  name = substr("${local.prefix}-app-alb", 0, 32)

  security_groups = [
    aws_security_group.lb.id
  ]
  subnets      = var.public_subnet_ids
  idle_timeout = 60

  tags = {
    Name = "${local.prefix}-app-alb"
  }
}

resource "aws_alb_target_group" "app" {
  name        = substr("${local.prefix}-app-tg", 0, 32)
  port        = var.nginx_container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = 3
    interval            = 30
    protocol            = "HTTP"
    matcher             = "302"
    timeout             = "5"
    path                = "/"
    unhealthy_threshold = 3
  }
}

resource "aws_alb_listener" "app-http" {
  load_balancer_arn = aws_alb.app.arn
  port              = 80
  protocol          = "HTTP"

   default_action {
     type = "redirect"

     redirect {
       port = 443
       protocol = "HTTPS"
       status_code = "HTTP_301"
     }
   }

  # default_action {
  #   target_group_arn = aws_alb_target_group.app.id
  #   type             = "forward"
  # }
}

resource "aws_alb_listener" "app-https" {
  load_balancer_arn = aws_alb.app.id
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.ssl_certificate_arn

  default_action {
    target_group_arn = aws_alb_target_group.app.id
    type             = "forward"
  }
}
