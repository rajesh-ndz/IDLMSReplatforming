terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" { region = var.region }

# Read NLB DNS from SSM (published by NLB stack)
data "aws_ssm_parameter" "lb_dns_name" { name = "${var.nlb_ssm_prefix}/lb_dns_name" }

# --- CloudWatch Logs for API Gateway access logs ---
resource "aws_cloudwatch_log_group" "apigw_access" {
  name              = "/aws/apigateway/${var.env_name}-idlms"
  retention_in_days = 14
  tags              = var.tags
}

# --- REST API ---
resource "aws_api_gateway_rest_api" "this" {
  name = "${var.env_name}-idlms-rest-api"
  endpoint_configuration { types = ["REGIONAL"] }
  tags = var.tags
}

# /{proxy+}
resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy_any" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "ANY"
  authorization = "NONE"
}

# INTERNET (no VPC link): API GW -> http://<nlb-dns>:<port>/{proxy}
resource "aws_api_gateway_integration" "proxy_any" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.proxy.id
  http_method             = aws_api_gateway_method.proxy_any.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "POST"
  uri                     = "http://${data.aws_ssm_parameter.lb_dns_name.value}:${var.nlb_port}/{proxy}"
}

# Root ANY -> /
resource "aws_api_gateway_method" "root_any" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_rest_api.this.root_resource_id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "root_any" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_rest_api.this.root_resource_id
  http_method             = aws_api_gateway_method.root_any.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "POST"
  uri                     = "http://${data.aws_ssm_parameter.lb_dns_name.value}:${var.nlb_port}/"
}

# Deploy
resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  triggers = {
    redeploy_hash = sha1(jsonencode({
      rest = aws_api_gateway_rest_api.this.id
      m1   = aws_api_gateway_method.proxy_any.id
      i1   = aws_api_gateway_integration.proxy_any.id
      m2   = aws_api_gateway_method.root_any.id
      i2   = aws_api_gateway_integration.root_any.id
    }))
  }
  lifecycle { create_before_destroy = true }
}

resource "aws_api_gateway_stage" "this" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  deployment_id = aws_api_gateway_deployment.this.id
  stage_name    = var.env_name
  tags          = var.tags

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.apigw_access.arn
    format          = "$context.requestId $context.identity.sourceIp $context.httpMethod $context.resourcePath $context.status $context.error.messageString $context.integration.status $context.integrationErrorMessage $context.responseLength"
  }
}

# Publish to SSM
resource "aws_ssm_parameter" "api_id" {
  count     = var.publish_to_ssm ? 1 : 0
  name      = "${var.restapi_ssm_prefix}/api_id"
  type      = "String"
  value     = aws_api_gateway_rest_api.this.id
  overwrite = true
}

resource "aws_ssm_parameter" "invoke_url" {
  count     = var.publish_to_ssm ? 1 : 0
  name      = "${var.restapi_ssm_prefix}/invoke_url"
  type      = "String"
  value     = "https://${aws_api_gateway_rest_api.this.id}.execute-api.${var.region}.amazonaws.com/${var.env_name}"
  overwrite = true
}

# Outputs
output "rest_api_id" { value = aws_api_gateway_rest_api.this.id }
output "stage_name" { value = aws_api_gateway_stage.this.stage_name }
output "invoke_url" { value = "https://${aws_api_gateway_rest_api.this.id}.execute-api.${var.region}.amazonaws.com/${var.env_name}" }
