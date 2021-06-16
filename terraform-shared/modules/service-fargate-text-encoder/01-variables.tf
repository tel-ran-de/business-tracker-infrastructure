variable "prefix" {}
variable "service_name" {}

variable "aws_region" {}
variable "vpc_id" {}
variable "vpc_cidr_block" {}
variable "private_subnet_ids" {
  type = list(string)
}

variable "aws_ecs_cluster_id" {}
variable "ecs_cpu_text_encoder" {}
variable "ecs_memory_text_encoder" {}
variable "text_encoder_container_port" {
  default = 5000
}
variable "cloudwatch_retention_in_days" {}

variable "ecs_task_execution_role_arn" {}
variable "text_encoder_ecs_role_arn" {}

variable "lb_security_groups" {
  type = list(string)
}

variable "extra_text_encoder_security_group_ids" {
  type = list(string)
}

