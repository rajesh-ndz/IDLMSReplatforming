resource "aws_ssm_parameter" "app_env" {
  name        = local.app_env_param_name
  type        = "SecureString"
  value       = var.app_env_content
  overwrite   = true

  lifecycle {
    # so we can import existing params without forcing a "change"
    ignore_changes = [ value ]
  }
}

resource "aws_ssm_parameter" "last_success" {
  name      = local.last_success_param_name
  type      = "String"
  value     = var.last_success_value
  overwrite = true

  lifecycle {
    ignore_changes = [ value ]
  }
}
