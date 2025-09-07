terraform {
  required_version = ">= 1.5.0"
  required_providers { aws = { source = "hashicorp/aws", version = ">= 5.0" } }
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config  = { bucket = var.tf_state_bucket, key = var.network_state_key, region = var.region }
}
data "terraform_remote_state" "compute" {
  backend = "s3"
  config  = { bucket = var.tf_state_bucket, key = var.compute_state_key, region = var.region }
}
data "terraform_remote_state" "ecr" {
  backend = "s3"
  config  = { bucket = var.tf_state_bucket, key = var.ecr_state_key, region = var.region }
}
data "terraform_remote_state" "nlb" {
  backend = "s3"
  config  = { bucket = var.tf_state_bucket, key = var.nlb_state_key, region = var.region }
}
data "terraform_remote_state" "rest_api" {
  backend = "s3"
  config  = { bucket = var.tf_state_bucket, key = var.rest_api_state_key, region = var.region }
}

locals {
  instance_id      = try(data.terraform_remote_state.compute.outputs.instance_id, null)
  ecr_repo_url     = try(
                      data.terraform_remote_state.ecr.outputs.repository_urls[0],
                      data.terraform_remote_state.ecr.outputs.repository_url,
                      data.terraform_remote_state.ecr.outputs.ecr_repository_url,
                      null)
  nlb_tg_4000      = try(
                      data.terraform_remote_state.nlb.outputs.tg_arn_4000,
                      data.terraform_remote_state.nlb.outputs.target_group_arn_4000,
                      data.terraform_remote_state.nlb.outputs.tg_4000,
                      null)
  apigw_invoke_url = try(
                      data.terraform_remote_state.rest_api.outputs.invoke_url,
                      data.terraform_remote_state.rest_api.outputs.apigw_invoke_url,
                      null)
}

output "instance_id"      { value = local.instance_id }
output "ecr_repo_url"     { value = local.ecr_repo_url }
output "nlb_tg_4000"      { value = local.nlb_tg_4000 }
output "apigw_invoke_url" { value = local.apigw_invoke_url }
