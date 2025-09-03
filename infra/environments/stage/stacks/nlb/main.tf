# Optional NLB remote state (guarded by count). Even with count=0,
# Terraform parses required args, so we pass coalesced values.
module "nlb_state" {
  count  = var.use_remote_state ? 1 : 0
  source = "../../../../platform/remote/nlb_state"

  bucket = coalesce(var.remote_state_bucket, "")
  key    = coalesce(var.remote_state_key, "")
  region = coalesce(var.remote_state_region, var.region)
}

# Read existing SSM values (you already have these)
data "aws_ssm_parameter" "lb_arn" {
  name = "${var.ssm_prefix}/lb_arn"
}
data "aws_ssm_parameter" "lb_dns_name" {
  name = "${var.ssm_prefix}/lb_dns_name"
}
data "aws_ssm_parameter" "lb_zone_id" {
  name = "${var.ssm_prefix}/lb_zone_id"
}

# Choose remote-state when enabled, else SSM fallbacks
locals {
  lb_arn            = var.use_remote_state ? module.nlb_state[0].lb_arn : data.aws_ssm_parameter.lb_arn.value
  lb_dns_name       = var.use_remote_state ? module.nlb_state[0].lb_dns_name : data.aws_ssm_parameter.lb_dns_name.value
  lb_zone_id        = var.use_remote_state ? module.nlb_state[0].lb_zone_id : data.aws_ssm_parameter.lb_zone_id.value
  listener_arns     = var.use_remote_state ? module.nlb_state[0].listener_arns : []
  target_group_arns = var.use_remote_state ? module.nlb_state[0].target_group_arns : []
}

# Publish to SSM using the correct interface (values/path_prefix/region)
module "publish" {
  count  = var.publish_to_ssm ? 1 : 0
  source = "../../../../platform/app/ssm_publish"

  region      = var.region
  path_prefix = var.ssm_prefix
  overwrite   = true

  values = {
    lb_arn            = local.lb_arn
    lb_dns_name       = local.lb_dns_name
    lb_zone_id        = local.lb_zone_id
    listener_arns     = jsonencode(local.listener_arns)
    target_group_arns = jsonencode(local.target_group_arns)
  }
}
