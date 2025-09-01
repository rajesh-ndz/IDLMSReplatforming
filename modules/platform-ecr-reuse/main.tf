terraform { required_version = ">= 1.5.0" }

data "terraform_remote_state" "ecr" {
  backend = "s3"
  config = {
    bucket = var.platform_state_bucket
    key    = var.platform_ecr_state_key
    region = var.platform_state_region
  }
}

locals {
  repository_names = try(data.terraform_remote_state.ecr.outputs.repository_names, [])
  repository_urls  = try(data.terraform_remote_state.ecr.outputs.repository_urls, [])
  repository_arns  = try(data.terraform_remote_state.ecr.outputs.repository_arns, [])
}
