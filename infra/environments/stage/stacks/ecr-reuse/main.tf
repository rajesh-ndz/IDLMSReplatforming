locals {
  platform_state_bucket  = var.platform_state_bucket
  platform_state_region  = var.platform_state_region
  platform_ecr_state_key = var.platform_ecr_state_key
}
data "terraform_remote_state" "ecr" {
  backend = "s3"
  config = {
    bucket = local.platform_state_bucket
    key    = local.platform_ecr_state_key
    region = local.platform_state_region
  }
}

locals {
  repository_names = try(data.terraform_remote_state.ecr.outputs.repository_names, [])
  repository_urls  = try(data.terraform_remote_state.ecr.outputs.repository_urls, [])
  repository_arns  = try(data.terraform_remote_state.ecr.outputs.repository_arns, [])
}
