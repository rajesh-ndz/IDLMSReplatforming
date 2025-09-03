data "terraform_remote_state" "platform_nlb" {
  backend = "s3"
  config = {
    bucket = var.platform_state_bucket
    key    = var.platform_nlb_state_key
    region = var.platform_state_region
  }
}

locals {
  platform_lb_arn        = try(data.terraform_remote_state.platform_nlb.outputs.lb_arn, null)
  platform_lb_dns_name   = try(data.terraform_remote_state.platform_nlb.outputs.lb_dns_name, null)
  platform_lb_zone_id    = try(data.terraform_remote_state.platform_nlb.outputs.lb_zone_id, null)
  platform_listener_arns = try(data.terraform_remote_state.platform_nlb.outputs.listener_arns, [])
  platform_tg_arns       = try(data.terraform_remote_state.platform_nlb.outputs.target_group_arns, [])
  vpc_link_id            = var.vpc_link_id
}
