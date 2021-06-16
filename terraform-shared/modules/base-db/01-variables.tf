variable "aws_region" {}
variable "prefix" {}
variable "stage" {}

variable "vpc_id" {}
variable "dns_zone_id" {}

variable "subnet_ids" {
  type = list(string)
}

variable "name" {}
variable "db_name" {}

variable "db_storage_size" {}
variable "db_engine_version" {}
variable "db_instance" {}

variable "SECRET_db_username" {}
variable "SECRET_db_password" {}
variable "db_maintenance_window" {}
variable "db_backup_window" {}
variable "db_backup_retention_period" {}
