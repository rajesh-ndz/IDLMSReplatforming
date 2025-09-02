output "lb_arn" {
  value     = data.aws_ssm_parameter.lb_arn.value
  sensitive = true
}
output "lb_dns_name" {
  value     = data.aws_ssm_parameter.lb_dns_name.value
  sensitive = true
}
output "lb_zone_id" {
  value     = data.aws_ssm_parameter.lb_zone_id.value
  sensitive = true
}
output "listener_map" {
  value     = local.ls_map
  sensitive = true
}
output "tg_map" {
  value     = local.tg_map
  sensitive = true
}
