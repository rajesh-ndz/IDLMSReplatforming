module "nlb_state" {
  source = "../../../../platform/remote/nlb_state"
  bucket = "idlms-terraform-state-backend"
  key    = "stage/nlb/terraform.tfstate"
  region = "ap-south-1"
}
module "publish" {
  count       = var.publish_to_ssm ? 1 : 0
  source      = "../../../../platform/app/ssm_publish"
  region      = var.region
  path_prefix = var.ssm_prefix
  values = {
    lb_arn            = module.nlb_state.lb_arn
    lb_dns_name       = module.nlb_state.lb_dns_name
    lb_zone_id        = module.nlb_state.lb_zone_id
    listener_arns     = jsonencode(module.nlb_state.listener_arns)
    target_group_arns = jsonencode(module.nlb_state.target_group_arns)
  }
}
output "lb_arn"            { value = module.nlb_state.lb_arn }
output "lb_dns_name"       { value = module.nlb_state.lb_dns_name }
output "lb_zone_id"        { value = module.nlb_state.lb_zone_id }
output "listener_arns"     { value = module.nlb_state.listener_arns }
output "target_group_arns" { value = module.nlb_state.target_group_arns }
output "published"         { value = try(module.publish[0].published, []) }
