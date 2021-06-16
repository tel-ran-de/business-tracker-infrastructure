variable "prefix" {}
variable "stage" {}

variable "vpc_id" {}
variable "dns_zone_id" {}

variable "subnet_id" {}

variable "aws_key_pair_name" {}
variable "ssh_private_key_path" {}

variable "ssh_authorized_keys" {
  type = list
}

variable "extra_security_group_ids" {
  type = list
}

variable "ami_id" {
  default = "ami-08b6fc871ad49ff41" # Ubuntu Server 20.04 LTS (HVM), SSD Volume Type, ARM
}

variable "instance_type" {
  default = "t4g.nano" # AWS ARM Graviton CPU, 0.5 GiB, 2 vCPUs for a 1h 12m burst, EBS only, Up to 5 Gigabit
}

variable "root_block_device_size" {
  default = 8 # GB
}
