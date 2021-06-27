resource "aws_alb" "fargate_service" {
  name = substr("${local.full_prefix}-private-alb", 0, 32)
  internal = true

  security_groups = [
    aws_security_group.public_lb.id
  ]
  subnets = var.private_subnet_ids
  idle_timeout = 60

  tags = {
    Name = "${local.full_prefix}-private-alb"
  }
}

resource "aws_alb_target_group" "fargate_service" {
  name = substr("${local.full_prefix}-tg", 0, 32)
  port = var.fargate_service_container_port
  protocol = "HTTP"
  vpc_id = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold = 3
    interval = 30
    protocol = "HTTP"
    matcher = "200"
    timeout = "5"
    path = "/ping"
    unhealthy_threshold = 3
  }
}

resource "aws_alb_listener" "fargate_service" {
  load_balancer_arn = aws_alb.fargate_service.arn

  port = var.fargate_service_container_port
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.fargate_service.arn
    type = "forward"
  }
}
