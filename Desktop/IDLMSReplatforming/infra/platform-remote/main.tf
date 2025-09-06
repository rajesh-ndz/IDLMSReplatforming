locals {
  network_key  = "${var.env_name}/network/terraform.tfstate"
  compute_key  = "${var.env_name}/compute/terraform.tfstate"
  nlb_key      = "${var.env_name}/nlb/terraform.tfstate"
  ecr_key      = "${var.env_name}/ecr/terraform.tfstate"
  rest_api_key = "${var.env_name}/rest-api/terraform.tfstate"
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = var.platform_state_bucket
    key    = local.network_key
    region = var.platform_state_region
  }
}

data "terraform_remote_state" "compute" {
  backend = "s3"
  config = {
    bucket = var.platform_state_bucket
    key    = local.compute_key
    region = var.platform_state_region
  }
}

data "terraform_remote_state" "nlb" {
  backend = "s3"
  config = {
    bucket = var.platform_state_bucket
    key    = local.nlb_key
    region = var.platform_state_region
  }
}

data "terraform_remote_state" "ecr" {
  backend = "s3"
  config = {
    bucket = var.platform_state_bucket
    key    = local.ecr_key
    region = var.platform_state_region
  }
}

# Optional (if rest-api stack is applied in platform-main)
data "terraform_remote_state" "rest_api" {
  backend = "s3"
  config = {
    bucket = var.platform_state_bucket
    key    = local.rest_api_key
    region = var.platform_state_region
  }
}
