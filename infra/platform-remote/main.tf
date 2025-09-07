terraform {
  required_version = ">= 1.5.0"
  required_providers { aws = { source = "hashicorp/aws", version = ">= 5.0" } }
}

data "terraform_remote_state" "compute" { backend = "s3" config = { bucket = var.tf_state_bucket key = var.compute_state_key region = var.region } }
data "terraform_remote_state" "ecr"     { backend = "s3" config = { bucket = var.tf_state_bucket key = var.ecr_state_key     region = var.region } }
data "terraform_remote_state" "nlb"     { backend = "s3" config = { bucket = var.tf_state_bucket key = var.nlb_state_key     region = var.region } }
data "terraform_remote_state" "rest_api"{ backend = "s3" config = { bucket = var.tf_state_bucket key = var.rest_api_state_key region = var.region } }

output "instance_id"       { value = try(data.terraform_remote_state.compute.outputs.instance_id, null) }
output "ecr_repo_url"      { value = try(data.terraform_remote_state.ecr.outputs.repository_urls[0], null) }
output "nlb_tg_4000"       { value = try(data.terraform_remote_state.nlb.outputs.tg_arn_4000, null) }
output "apigw_invoke_url"  { value = try(data.terraform_remote_state.rest_api.outputs.invoke_url, null) }
