terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# Read network outputs from platform-main's S3 state
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = var.remote_state_bucket
    key    = var.remote_state_key_network # e.g. "stage/network/terraform.tfstate"
    region = var.remote_state_region
  }
}

# (Optional) publish to SSM so pipelines/other stacks can read without remote_state
locals {
  ssm_prefix = var.ssm_prefix
}

resource "aws_ssm_parameter" "vpc_id" {
  count = var.publish_to_ssm ? 1 : 0
  name  = "${local.ssm_prefix}/vpc_id"
  type  = "String"
  value = data.terraform_remote_state.network.outputs.vpc_id
}

resource "aws_ssm_parameter" "public_subnet_ids" {
  count = var.publish_to_ssm ? 1 : 0
  name  = "${local.ssm_prefix}/public_subnet_ids"
  type  = "StringList"
  value = join(",", data.terraform_remote_state.network.outputs.public_subnet_ids)
}

resource "aws_ssm_parameter" "private_subnet_ids" {
  count = var.publish_to_ssm ? 1 : 0
  name  = "${local.ssm_prefix}/private_subnet_ids"
  type  = "StringList"
  value = join(",", data.terraform_remote_state.network.outputs.private_subnet_ids)
}

output "vpc_id" {
  value = data.terraform_remote_state.network.outputs.vpc_id
}

output "public_subnet_ids" {
  value = data.terraform_remote_state.network.outputs.public_subnet_ids
}

output "private_subnet_ids" {
  value = data.terraform_remote_state.network.outputs.private_subnet_ids
}
