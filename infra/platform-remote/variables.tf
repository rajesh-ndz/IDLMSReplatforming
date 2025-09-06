variable "env_name" {
  type        = string
  description = "Environment name (e.g., stage)"
}

variable "region" {
  type        = string
  description = "AWS Region for data reads (ap-south-1)"
}

variable "platform_state_bucket" {
  type        = string
  description = "S3 bucket holding platform-main tfstate objects"
}

variable "platform_state_region" {
  type        = string
  description = "Region where the state bucket lives"
}
