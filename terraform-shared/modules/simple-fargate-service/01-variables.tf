variable "prefix" {}
variable "service_name" {}

variable "dns_names" {}
variable "dns_zone_id" {}

variable "aws_region" {}
variable "vpc_id" {}
variable "vpc_cidr_block" {}
variable "private_subnet_ids" {
  type = list(string)
}
variable "public_subnet_ids" {
  type = list(string)
}

variable "aws_ecs_cluster_id" {}
variable "ecs_cpu_fargate_service" {}
variable "ecs_memory_fargate_service" {}
variable "fargate_service_container_port" {
  default = 5000
}
variable "cloudwatch_retention_in_days" {}

variable "ecs_task_execution_role_arn" {}
variable "fargate_service_ecs_role_arn" {}

variable "extra_fargate_service_security_group_ids" {
  type = list(string)
}

variable "db_client_sg_id" {}

