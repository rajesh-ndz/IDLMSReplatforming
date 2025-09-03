output "lb_arn"            { value = data.terraform_remote_state.nlb.outputs.lb_arn }
output "lb_dns_name"       { value = data.terraform_remote_state.nlb.outputs.lb_dns_name }
output "lb_zone_id"        { value = data.terraform_remote_state.nlb.outputs.lb_zone_id }
output "listener_arns"     { value = data.terraform_remote_state.nlb.outputs.listener_arns }
output "target_group_arns" { value = data.terraform_remote_state.nlb.outputs.target_group_arns }
