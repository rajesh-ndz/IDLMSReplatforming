variable "platform_state_bucket" {
  description = "S3 bucket where platform-main stores state"
  type        = string
}
variable "platform_nlb_state_key" {
  description = "S3 key for platform-main's NLB state (per env)"
  type        = string
}
variable "platform_state_region" {
  description = "Region of the platform-main state bucket"
  type        = string
  default     = "ap-south-1"
}

data "terraform_remote_state" "platform_nlb" {
  backend = "s3"
  config = {
    bucket = var.platform_state_bucket
    key    = var.platform_nlb_state_key
    region = var.platform_state_region
  }
}

locals {
  platform_lb_arn        = data.terraform_remote_state.platform_nlb.outputs.lb_arn
  platform_lb_dns_name   = data.terraform_remote_state.platform_nlb.outputs.lb_dns_name
  platform_lb_zone_id    = data.terraform_remote_state.platform_nlb.outputs.lb_zone_id
  platform_listener_arns = data.terraform_remote_state.platform_nlb.outputs.listener_arns
  platform_tg_arns       = data.terraform_remote_state.platform_nlb.outputs.target_group_arns
}
