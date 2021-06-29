module "fargate_java_server" {
  source = "../terraform-shared/modules/simple-fargate-service"

  prefix = local.prefix
  service_name = "java-server"

  aws_region = var.aws_region
  vpc_id = module.vpc.vpc_id
  vpc_cidr_block = var.cidr_block
  private_subnet_ids = module.vpc.private_subnets
  public_subnet_ids = module.vpc.public_subnets

  aws_ecs_cluster_id = aws_ecs_cluster.main.id

  ecs_cpu_fargate_service = 512
  ecs_memory_fargate_service = 1024
  cloudwatch_retention_in_days = 7

  ecs_task_execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  fargate_service_ecs_role_arn = aws_iam_role.ecs_task_execution_role.arn

  extra_fargate_service_security_group_ids = []
  db_client_sg_id = module.db.db_client_sg_id

  fargate_service_container_port = 80

  dns_names = [
    "${data.aws_route53_zone.master.name}"
  ]
  dns_zone_id = var.base_dns_zone_id
}
