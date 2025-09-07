data "aws_ssm_parameter" "bucket_name" {
  name = "${var.ssm_prefix}/${var.environment}/bucket_name"
}

data "aws_ssm_parameter" "default_key" {
  name = "${var.ssm_prefix}/${var.environment}/default_key"
}
