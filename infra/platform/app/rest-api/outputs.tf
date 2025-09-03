locals {
  has_api = var.enabled && length(aws_api_gateway_rest_api.this) > 0
}

output "rest_api_id" {
  value       = local.has_api ? aws_api_gateway_rest_api.this[0].id : null
  description = "REST API ID"
}

output "invoke_url" {
  value       = local.has_api ? "https://${aws_api_gateway_rest_api.this[0].id}.execute-api.${var.region}.amazonaws.com/${var.stage_name}" : null
  description = "Base invoke URL"
}

output "stage_name" {
  value       = var.stage_name
  description = "Stage name"
}
