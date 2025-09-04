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

# Read compute outputs from platform-main's S3 state
data "terraform_remote_state" "compute" {
  backend = "s3"
  config = {
    bucket = var.remote_state_bucket
    key    = var.remote_state_key_compute # e.g. "stage/compute/terraform.tfstate"
    region = var.remote_state_region
  }
}

locals {
  ssm_prefix = var.ssm_prefix
}

# Optional: publish to SSM so other stacks/pipelines can read easily
resource "aws_ssm_parameter" "instance_id" {
  count = var.publish_to_ssm ? 1 : 0
  name  = "${local.ssm_prefix}/instance_id"
  type  = "String"
  value = data.terraform_remote_state.compute.outputs.instance_id
}

resource "aws_ssm_parameter" "instance_private_ip" {
  count = var.publish_to_ssm ? 1 : 0
  name  = "${local.ssm_prefix}/instance_private_ip"
  type  = "String"
  value = data.terraform_remote_state.compute.outputs.instance_private_ip
}

resource "aws_ssm_parameter" "security_group_id" {
  count = var.publish_to_ssm ? 1 : 0
  name  = "${local.ssm_prefix}/security_group_id"
  type  = "String"
  value = data.terraform_remote_state.compute.outputs.security_group_id
}

output "instance_id" {
  value = data.terraform_remote_state.compute.outputs.instance_id
}

output "instance_private_ip" {
  value = data.terraform_remote_state.compute.outputs.instance_private_ip
}

output "security_group_id" {
  value = data.terraform_remote_state.compute.outputs.security_group_id
}
