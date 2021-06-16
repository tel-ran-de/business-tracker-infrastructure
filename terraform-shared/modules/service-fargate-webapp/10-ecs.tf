resource "aws_ecs_task_definition" "app" {
  family       = "${local.prefix}-app-task"
  network_mode = "awsvpc"
  requires_compatibilities = [
  "FARGATE"]
  cpu                = var.ecs_cpu_app
  memory             = var.ecs_memory_app
  execution_role_arn = var.ecs_task_execution_role_arn
  task_role_arn      = var.app_role_arn
  container_definitions = jsonencode(
    [
      // app DB migration
      {
        name      = local.migration_container_name
        image     = module.app_ecr.repository_url
        essential = false

        command = [
        "bin/ecs-run-db-migrations"]

        logConfiguration = {
          logDriver = "awslogs"
          options = {
            awslogs-group         = local.cloudwatch_migration_log_group_name
            awslogs-region        = var.aws_region,
            awslogs-stream-prefix = "ecs"
          }
        },
	environment = var.app_env_vars,
	secrets = var.app_secret_vars
      },

      // nginx
      {
        name      = local.nginx_container_name
        image     = module.nginx_ecr.repository_url
        essential = true
        portMappings = [
          {
            protocol      = "tcp"
            containerPort = var.nginx_container_port
            hostPort      = var.nginx_container_port
          }
        ]

        logConfiguration = {
          logDriver = "awslogs"
          options = {
            awslogs-group         = local.cloudwatch_nginx_log_group_name
            awslogs-region        = var.aws_region,
            awslogs-stream-prefix = "ecs"
          }
        },

	environment = var.nginx_env_vars
	secrets = var.app_secret_vars
      },
      // app
      {
        name      = local.app_container_name
        image     = module.app_ecr.repository_url
        essential = false

        command = [
        "bin/ecs-run-puma"]

        portMappings = [
          {
            protocol      = "tcp"
            containerPort = var.app_container_port
            hostPort      = var.app_container_port
          }
        ],

        dependsOn = [
          {
            containerName = local.migration_container_name,
            condition     = "SUCCESS"
        }],

        logConfiguration = {
          logDriver = "awslogs"
          options = {
            awslogs-group         = local.cloudwatch_log_group_name
            awslogs-region        = var.aws_region,
            awslogs-stream-prefix = "ecs"
          }
        },
	environment = var.app_env_vars,
	secrets = var.app_secret_vars
  }])
}

resource "aws_ecs_service" "app" {
  name                               = "${local.prefix}-app-service"
  cluster                            = var.aws_ecs_cluster_id
  task_definition                    = aws_ecs_task_definition.app.arn
  desired_count                      = 1
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"

  network_configuration {
    security_groups = [aws_security_group.app.id, var.db_client_sg_id]
    subnets          = var.private_subnet_ids
    assign_public_ip = false
  }

  dynamic "load_balancer" {
    for_each = concat([aws_alb_target_group.app.arn], var.extra_alb_target_groups)
    content {
      target_group_arn = load_balancer.value
      container_name   = local.nginx_container_name
      container_port   = var.nginx_container_port
    }
  }

  lifecycle {
    ignore_changes = [
      task_definition,
      desired_count
    ]
  }
}

output "app_ecs_service_arn" {
  value = aws_ecs_service.app.id
}
output "app_ecs_task_arn" {
  value = aws_ecs_task_definition.app.arn
}
