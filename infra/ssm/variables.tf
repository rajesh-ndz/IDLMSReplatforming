variable "env" {
  description = "Environment name (e.g., dev|stage|prod)"
  type        = string
}

# OPTIONAL overrides; usually you don't need to set these
variable "app_env_param_name" {
  description = "Full SSM path for the app .env parameter"
  type        = string
  default     = null
}
variable "last_success_param_name" {
  description = "Full SSM path for last successful build tag"
  type        = string
  default     = null
}

# Required by resource schema but ignored for drift; used only if you 'apply'
variable "app_env_content" {
  description = "Placeholder content for the .env SecureString (ignored on import)"
  type        = string
  default     = "# placeholder"
}
variable "last_success_value" {
  description = "Placeholder for last-successful-build param (ignored on import)"
  type        = string
  default     = "placeholder"
}

locals {
  app_env_param_name      = coalesce(var.app_env_param_name, "/idlms/shared/${var.env}/.env")
  last_success_param_name = coalesce(var.last_success_param_name, "/idlms/license-api/last-successful-build")
}
