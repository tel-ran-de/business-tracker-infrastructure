variable "aws_region" {}
variable "prefix" {}
variable "stage" {}

variable "cidr_block" {}
variable "zones" {
  type = list(object({
    zone           = string
    public_subnet  = string
    private_subnet = string
  }))
}
