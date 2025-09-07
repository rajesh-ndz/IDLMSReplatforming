variable "env_name" {
  description = "Environment name (dev|stage|prod)"
  type        = string
}
variable "region" {
  description = "AWS region for provider operations"
  type        = string
}
variable "platform_state_bucket" {
  description = "S3 bucket that stores platform-main states"
  type        = string
}
variable "platform_state_region" {
  description = "Region of the platform-main state bucket"
  type        = string
}
