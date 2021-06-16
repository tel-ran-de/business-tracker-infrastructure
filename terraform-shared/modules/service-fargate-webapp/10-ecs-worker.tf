resource "aws_ecs_task_definition" "worker" {
  family             = "${local.prefix}-worker-task"
  network_mode       = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                = var.ecs_cpu_worker
  memory             = var.ecs_memory_worker
  execution_role_arn = var.ecs_task_execution_role_arn
  task_role_arn      = var.app_role_arn
  container_definitions = jsonencode(
    [
      // app worker
      {
	name      = local.worker_container_name
	image     = module.app_ecr.repository_url
	essential = true

	command   = ["bin/ecs-run-delayed-job"]

	logConfiguration = {
	  logDriver = "awslogs"
	  options = {
	    awslogs-group         = local.cloudwatch_worker_log_group_name
	    awslogs-region        = var.aws_region,
	    awslogs-stream-prefix = "ecs"
	  }
	},
	environment = var.app_env_vars,
	secrets = var.app_secret_vars
    }])
}

resource "aws_ecs_service" "worker" {
  name                               = "${local.prefix}-worker-service"
  cluster                            = var.aws_ecs_cluster_id
  task_definition                    = aws_ecs_task_definition.worker.arn
  desired_count                      = 1
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"

  network_configuration {
    security_groups = [aws_security_group.app.id, var.db_client_sg_id]
    subnets = var.private_subnet_ids
    assign_public_ip = false
  }

  lifecycle {
    ignore_changes = [
      task_definition,
      desired_count
    ]
  }
}

output "worker_ecs_service_arn" { value = aws_ecs_service.worker.id }
output "worker_ecs_task_arn" { value = aws_ecs_task_definition.worker.arn }
