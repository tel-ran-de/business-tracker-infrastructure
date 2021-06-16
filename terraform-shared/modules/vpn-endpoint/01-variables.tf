variable "prefix" {}
variable "vpc_id" {}
variable "vpc_cidr" {}
variable "vpn_subnet_ids" {
  type = list(string)
}

variable "alb_subnet_ids" {
  type = list(string)
}

variable "client_cidr_block" {}

variable "server_cert_arn" {}
variable "client_cert_arn" {}

variable "ssl_certificate_arn" {}

variable "is_split_tunnel" {
  type = bool
}

variable "dns_servers" {
  type = list(string)
}

variable "cloudwatch_retention_in_days" {}

variable "backend_port" {
  default = 80
}
variable "dns_zone_id" {}
variable "admin_backend_domain" {}
