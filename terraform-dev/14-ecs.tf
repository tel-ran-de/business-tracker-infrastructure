resource "aws_ecs_cluster" "main" {
  name = "${local.prefix}-cluster"
}

output "ECS_CLUSTER_ARN" { value = aws_ecs_cluster.main.arn }
