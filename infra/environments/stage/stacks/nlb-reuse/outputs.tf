output "lb_arn"            { value = module.nlb_ssm.lb_arn }
output "lb_dns_name"       { value = module.nlb_ssm.lb_dns_name }
output "listener_arns"     { value = module.nlb_ssm.listener_arns }
output "target_group_arns" { value = module.nlb_ssm.target_group_arns }
