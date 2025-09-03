output "lb_arn" {
  value     = local.lb_arn
  sensitive = true
}
output "lb_dns_name" {
  value     = local.lb_dns_name
  sensitive = true
}
output "lb_zone_id" {
  value     = local.lb_zone_id
  sensitive = true
}
output "listener_arns" {
  value = local.listener_arns
}
output "target_group_arns" {
  value = local.target_group_arns
}
