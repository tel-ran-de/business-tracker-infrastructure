module "vpc" {
  source = "../terraform-shared/modules/base-vpc"
  prefix = local.prefix
  stage  = var.stage
  aws_region = var.aws_region
  cidr_block = var.cidr_block
  zones = var.zones
}
