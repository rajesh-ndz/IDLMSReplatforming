output "lb_arn"            { value = data.terraform_remote_state.nlb.outputs.lb_arn }
output "lb_dns_name"       { value = data.terraform_remote_state.nlb.outputs.lb_dns_name }
output "lb_zone_id"        { value = data.terraform_remote_state.nlb.outputs.lb_zone_id }
output "target_group_arns" { value = data.terraform_remote_state.nlb.outputs.target_group_arns }
output "listener_arns"     { value = data.terraform_remote_state.nlb.outputs.listener_arns }

# SSM convenience maps (provider v6 treats SSM values as sensitive)
output "ssm_target_group_map" {
  value     = local.tg_map
  sensitive = true
}
output "ssm_listener_map" {
  value     = local.ls_map
  sensitive = true
}
