output "rest_api_id" { value = try(aws_api_gateway_rest_api.this[0].id, null) }
output "invoke_url" { value = try("https://${aws_api_gateway_rest_api.this[0].id}.execute-api.${var.region}.amazonaws.com/${var.stage_name}", null) }
output "stage_name" { value = try(aws_api_gateway_stage.this[0].stage_name, null) }
