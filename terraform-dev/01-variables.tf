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
