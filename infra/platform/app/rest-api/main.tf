locals { do = var.enabled }
data "aws_ssm_parameter" "lb_dns" { name = "${var.nlb_ssm_prefix}/lb_dns_name" }
resource "aws_cloudwatch_log_group" "apigw_access" {
  count = local.do ? 1 : 0
  name = "/aws/apigateway/${var.api_name}-${var.stage_name}-access"
  retention_in_days = var.access_log_retention_days
  tags = { Environment = var.env_name, Project = "IDLMS" }
}
resource "aws_api_gateway_rest_api" "this" {
  count = local.do ? 1 : 0
  name  = var.api_name
  description = var.description
  endpoint_configuration { types = [var.endpoint_type] }
  tags = { Environment = var.env_name, Project = "IDLMS" }
}
resource "aws_api_gateway_resource" "proxy" {
  count = local.do ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.this[0].id
  parent_id   = aws_api_gateway_rest_api.this[0].root_resource_id
  path_part   = "{proxy+}"
}
resource "aws_api_gateway_method" "any" {
  count = local.do ? 1 : 0
  rest_api_id   = aws_api_gateway_rest_api.this[0].id
  resource_id   = aws_api_gateway_resource.proxy[0].id
  http_method   = "ANY"
  authorization = "NONE"
  request_parameters = { "method.request.path.proxy" = true }
}
resource "aws_api_gateway_integration" "http_proxy" {
  count = local.do ? 1 : 0
  rest_api_id             = aws_api_gateway_rest_api.this[0].id
  resource_id             = aws_api_gateway_resource.proxy[0].id
  http_method             = aws_api_gateway_method.any[0].http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "ANY"
  uri                     = "http://${data.aws_ssm_parameter.lb_dns.value}:${var.port}/{proxy}"
  request_parameters      = { "integration.request.path.proxy" = "method.request.path.proxy" }
}
resource "aws_api_gateway_method_response" "r200" {
  count = local.do ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.this[0].id
  resource_id = aws_api_gateway_resource.proxy[0].id
  http_method = aws_api_gateway_method.any[0].http_method
  status_code = "200"
}
resource "aws_api_gateway_integration_response" "i200" {
  count = local.do ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.this[0].id
  resource_id = aws_api_gateway_resource.proxy[0].id
  http_method = aws_api_gateway_method.any[0].http_method
  status_code = aws_api_gateway_method_response.r200[0].status_code
}
resource "aws_api_gateway_deployment" "this" {
  count = local.do ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.this[0].id
  triggers = { redeploy_hash = timestamp() }
  lifecycle { create_before_destroy = true }
}
resource "aws_api_gateway_stage" "this" {
  count = local.do ? 1 : 0
  rest_api_id   = aws_api_gateway_rest_api.this[0].id
  deployment_id = aws_api_gateway_deployment.this[0].id
  stage_name    = var.stage_name
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.apigw_access[0].arn
    format = jsonencode({
      requestId = "$context.requestId",
      ip = "$context.identity.sourceIp",
      user = "$context.identity.user",
      requestTime = "$context.requestTime",
      httpMethod = "$context.httpMethod",
      path = "$context.path",
      status = "$context.status",
      protocol = "$context.protocol",
      responseLength = "$context.responseLength"
    })
  }
}
