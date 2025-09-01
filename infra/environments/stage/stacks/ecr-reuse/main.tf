terraform { required_version = ">= 1.5.0" }

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
