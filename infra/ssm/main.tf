terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = ">= 5.0.0" }
  }
}
provider "aws" {}

locals {
  shared_env_name = "/idlms/shared/${var.env}/.env"
  last_success    = "/idlms/license-api/last-successful-build"
  env_b64         = coalesce(var.app_env_content_b64, var.app_env_content, base64encode("# placeholder env"))
}

# SecureString .env
resource "aws_ssm_parameter" "app_env" {
  name        = local.shared_env_name
  description = "IDLMS ${var.env} application .env"
  type        = "SecureString"
  value       = base64decode(local.env_b64)
  overwrite   = true
}

# Simple String for last-successful-build (CI updates value; TF owns lifecycle)
resource "aws_ssm_parameter" "last_success" {
  count       = var.manage_last_success_param ? 1 : 0
  name        = local.last_success
  description = "IDLMS license API last good image tag"
  type        = "String"
  value       = "bootstrap"
  overwrite   = true

  # CI will change the value after a good deploy; don't fight drift, but allow destroy
  lifecycle {
    ignore_changes = [value]
  }
}
