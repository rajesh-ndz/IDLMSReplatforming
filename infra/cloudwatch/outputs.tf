output "log_group_name" { value = try(aws_cloudwatch_log_group.app[0].name, null) }
output "dashboard_name" { value = try(aws_cloudwatch_dashboard.this[0].dashboard_name, null) }
