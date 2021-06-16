resource "aws_ecs_task_definition" "text_encoder" {
  family = "${local.full_prefix}-task"
  network_mode = "awsvpc"
  requires_compatibilities = [
    "FARGATE"]
  cpu = var.ecs_cpu_text_encoder
  memory = var.ecs_memory_text_encoder
  execution_role_arn = var.ecs_task_execution_role_arn
  task_role_arn = var.text_encoder_ecs_role_arn
  container_definitions = jsonencode(
  [
    {
      name = "${local.full_prefix}-container"
      image = module.ecr.repository_url
      essential = true
      portMappings = [
        {
          protocol = "tcp"
          containerPort = var.text_encoder_container_port
          hostPort = var.text_encoder_container_port
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group = local.cloudwatch_log_group_name
          awslogs-region = var.aws_region,
          awslogs-stream-prefix = "ecs"
        }
      },

    }
  ])
}

resource "aws_ecs_service" "text_encoder" {
  name = "${local.full_prefix}-service"
  cluster = var.aws_ecs_cluster_id
  task_definition = aws_ecs_task_definition.text_encoder.arn
  desired_count = 1
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent = 200
  launch_type = "FARGATE"
  scheduling_strategy = "REPLICA"

  network_configuration {
    security_groups = concat([
      aws_security_group.text_encoder.id], var.extra_text_encoder_security_group_ids)
    subnets = var.private_subnet_ids
    assign_public_ip = false
  }
  load_balancer {
    target_group_arn = aws_alb_target_group.text_encoder.arn
    container_name = "${local.full_prefix}-container"
    container_port = var.text_encoder_container_port
  }

  lifecycle {
    ignore_changes = [
      task_definition,
      desired_count
    ]
  }
}
