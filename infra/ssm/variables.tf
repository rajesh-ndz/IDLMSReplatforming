# Which environment are we writing under (dev|stage|prod)
variable "env" {
  description = "Environment name"
  type        = string
}

# CI passes the .env content base64-encoded; we support both var names for compatibility
variable "app_env_content_b64" {
  description = "Base64 of .env content for /idlms/shared/<env>/.env"
  type        = string
  default     = null
}
variable "app_env_content" {
  description = "Alias (also base64) for compatibility with older workflow"
  type        = string
  default     = null
}

# Let Terraform create & manage the "last successful build" key too
variable "manage_last_success_param" {
  description = "If true, manage /idlms/license-api/last-successful-build as TF resource"
  type        = bool
  default     = true
}
