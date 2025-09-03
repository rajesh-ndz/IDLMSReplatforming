output "vpc_link_id" {
  value = var.vpc_link_id
}

# Echo the platform-main NLB values we read via remote state
output "platform_lb_arn" {
  value = local.platform_lb_arn
}
output "platform_lb_dns_name" {
  value = local.platform_lb_dns_name
}
output "platform_lb_zone_id" {
  value = local.platform_lb_zone_id
}
