output "lb_arn" {
  value     = module.nlb_ssm.lb_arn
  sensitive = true
}

output "lb_dns_name" {
  value     = module.nlb_ssm.lb_dns_name
  sensitive = true
}

output "listener_arns" {
  value     = module.nlb_ssm.listener_arns
  sensitive = true
}

output "target_group_arns" {
  value     = module.nlb_ssm.target_group_arns
  sensitive = true
}

# Derived from AWS using the ARN; not sensitive
output "lb_zone_id" {
  value = data.aws_lb.nlb.zone_id
}
