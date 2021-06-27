variable "infrastructure_version" {}

variable "aws_region" {}
variable "aws_profile" {}
variable "stage" {}

variable "project_name" {}

variable "cidr_block" {}

variable "zones" {
  type = list(object({
    zone           = string
    public_subnet  = string
    private_subnet = string
  }))
}

variable "base_domain_name" {}
variable "base_dns_zone_id" {}

variable "SECRET_base_db_username" {}
variable "SECRET_base_db_password" {}

variable "base_db_storage_size" {}
variable "base_db_engine_version" {}
variable "base_db_instance" {}
variable "base_db_maintenance_window" {}
variable "base_db_backup_window" {}
variable "base_db_backup_retention_period" {}
