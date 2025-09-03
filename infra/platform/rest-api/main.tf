locals {
  backend_url = "http://${data.aws_ssm_parameter.lb_dns_name.value}:${var.port}"
}

data "aws_ssm_parameter" "lb_dns_name" {
  name = "${var.nlb_ssm_prefix}/lb_dns_name"
}

resource "aws_api_gateway_rest_api" "this" {
  count       = var.enabled ? 1 : 0
  name        = var.api_name
  description = var.description
  endpoint_configuration { types = [var.endpoint_type] }
}

# /{proxy+}
resource "aws_api_gateway_resource" "proxy" {
  count       = var.enabled ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.this[0].id
  parent_id   = aws_api_gateway_rest_api.this[0].root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
  count         = var.enabled ? 1 : 0
  rest_api_id   = aws_api_gateway_rest_api.this[0].id
  resource_id   = aws_api_gateway_resource.proxy[0].id
  http_method   = "ANY"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "proxy" {
  count                   = var.enabled ? 1 : 0
  rest_api_id             = aws_api_gateway_rest_api.this[0].id
  resource_id             = aws_api_gateway_resource.proxy[0].id
  http_method             = aws_api_gateway_method.proxy[0].http_method
  type                    = "HTTP_PROXY"
  uri                     = "${local.backend_url}/{proxy}"
  integration_http_method = "ANY"
  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }
}

# /
resource "aws_api_gateway_method" "root" {
  count         = var.enabled ? 1 : 0
  rest_api_id   = aws_api_gateway_rest_api.this[0].id
  resource_id   = aws_api_gateway_rest_api.this[0].root_resource_id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "root" {
  count                   = var.enabled ? 1 : 0
  rest_api_id             = aws_api_gateway_rest_api.this[0].id
  resource_id             = aws_api_gateway_rest_api.this[0].root_resource_id
  http_method             = aws_api_gateway_method.root[0].http_method
  type                    = "HTTP_PROXY"
  uri                     = length(var.root_path) > 0 ? "${local.backend_url}${var.root_path}" : local.backend_url
  integration_http_method = "ANY"
}

resource "aws_cloudwatch_log_group" "access_logs" {
  count             = var.enabled ? 1 : 0
  name              = "/aws/apigateway/${var.api_name}-${var.stage_name}"
  retention_in_days = var.access_log_retention_days
}

resource "aws_api_gateway_deployment" "this" {
  count       = var.enabled ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.this[0].id
  triggers = {
    redeploy = sha1(jsonencode({
      rest_api = aws_api_gateway_rest_api.this[0].id
      proxy_m  = aws_api_gateway_method.proxy[0].id
      proxy_i  = aws_api_gateway_integration.proxy[0].id
      root_m   = aws_api_gateway_method.root[0].id
      root_i   = aws_api_gateway_integration.root[0].id
      root_p   = var.root_path
    }))
  }
  lifecycle { create_before_destroy = true }
  depends_on = [aws_api_gateway_integration.proxy, aws_api_gateway_integration.root]
}

resource "aws_api_gateway_stage" "this" {
  count         = var.enabled ? 1 : 0
  rest_api_id   = aws_api_gateway_rest_api.this[0].id
  deployment_id = aws_api_gateway_deployment.this[0].id
  stage_name    = var.stage_name
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.access_logs[0].arn
    format = jsonencode({
      requestId      = "$context.requestId"
      ip             = "$context.identity.sourceIp"
      requestTime    = "$context.requestTime"
      httpMethod     = "$context.httpMethod"
      resourcePath   = "$context.resourcePath"
      status         = "$context.status"
      protocol       = "$context.protocol"
      responseLength = "$context.responseLength"
    })
  }
}
