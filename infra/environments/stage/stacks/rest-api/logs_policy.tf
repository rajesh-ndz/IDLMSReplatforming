resource "aws_cloudwatch_log_resource_policy" "apigw_access" {
  policy_name = "${var.env_name}-apigw-access-logs"
  policy_document = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Sid : "ApiGatewayAccessLogs",
      Effect : "Allow",
      Principal : { Service : "apigateway.amazonaws.com" },
      Action : ["logs:CreateLogStream", "logs:PutLogEvents"],
      Resource : [
        "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/apigateway/${var.env_name}-idlms",
        "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/apigateway/${var.env_name}-idlms:log-stream:*"
      ]
    }]
  })
}
