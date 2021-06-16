variable "aws_region" {}
variable "prefix" {}
variable "stage" {}

variable "name" {}

variable "vpc_id" {}
variable "dns_zone_id" {}
variable "dns_names" {}

variable "aws_ecs_cluster_id" {}

variable "ssl_certificate_arn" {}

variable "public_subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "extra_security_group_ids" {
  type = list(string)
}

variable "db_client_sg_id" {
  type = string
}

variable "cloudwatch_retention_in_days" {}

variable "ecs_cpu_app" {
  default = 1024
}

variable "ecs_memory_app" {
  default = 2048
}

variable "ecs_cpu_worker" {
  default = 1024
}

variable "ecs_memory_worker" {
  default = 2048
}

variable "nginx_container_port" {
  default = 80
}

variable "app_container_port" {
  default = 3000
}

variable "app_env_vars" {
  type = list(object({
    name  = string
    value = string
  }))
}

variable "app_secret_vars" {
  type = list(object({
    name  = string
    valueFrom = string
  }))
}

variable "nginx_env_vars" {
  type = list(object({
    name  = string
    value = string
  }))

  default = []
}

variable "ecs_task_execution_role_arn" {}
variable "app_role_arn" {}

variable "extra_alb_target_groups" {
  type = list(string)
  default = []
}
