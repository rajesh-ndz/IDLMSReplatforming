terraform {
  required_version = ">= 1.5.0"
}

locals {
  nlb_ssm_prefix = "/idlms/nlb/stage"
  region         = "ap-south-1"
}

module "nlb_ssm" {
  source = "../../../../../modules/platform-ssm-reuse"

  region         = local.region
  nlb_ssm_prefix = local.nlb_ssm_prefix
}
