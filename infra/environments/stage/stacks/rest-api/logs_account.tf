data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

resource "aws_iam_role" "apigw_cw_role" {
  name = "${var.env_name}-idlms-apigw-cw-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { Service = "apigateway.amazonaws.com" },
      Action    = "sts:AssumeRole"
    }]
  })
  tags = var.tags
}

resource "aws_iam_role_policy" "apigw_cw_policy" {
  name = "${var.env_name}-idlms-apigw-cw-policy"
  role = aws_iam_role.apigw_cw_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams",
        "logs:PutLogEvents"
      ],
      Resource = "*"
    }]
  })
}

# Set the CloudWatch role for API Gateway in this account/region
resource "aws_api_gateway_account" "this" {
  cloudwatch_role_arn = aws_iam_role.apigw_cw_role.arn
}
