terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.45"
    }
  }

  backend "s3" {
    bucket  = "starta-terraform-v1"
    key     = "dev/v1/state/terraform.tfstate"
    region  = "eu-north-1"//var.aws_region
    profile = "telran"//var.aws_profile
  }
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region

  default_tags {
    tags = {
      Deployer = "Terraform"
      Stage = var.stage
    }
  }
}

//resource "aws_key_pair" "base" {
//  key_name   = local.master_ssh_key_name
//  public_key = file(var.master_ssh_key_path)
//}
