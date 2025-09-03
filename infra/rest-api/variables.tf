variable "env" {
  description = "Environment name (dev|stage|prod)"
  type        = string
  validation {
    condition     = length(trimspace(var.env)) > 0
    error_message = "var.env must be set (e.g., dev|stage|prod)."
  }
}

variable "vpc_link_id" {
  description = "Existing API Gateway VPC Link ID to reuse (e.g., hda1q1)"
  type        = string
  validation {
    condition     = length(trimspace(var.vpc_link_id)) > 0
    error_message = "vpc_link_id must be set (e.g., hda1q1)."
  }
}

variable "platform_state_bucket" {
  description = "S3 bucket that holds platform-main state"
  type        = string
  validation {
    condition     = length(trimspace(var.platform_state_bucket)) > 0
    error_message = "platform_state_bucket must be provided (see stage.tfvars)."
  }
}

variable "platform_nlb_state_key" {
  description = "Key of the platform NLB state file in the bucket"
  type        = string
  validation {
    condition     = length(trimspace(var.platform_nlb_state_key)) > 0
    error_message = "platform_nlb_state_key must be provided (e.g., stage/container/nlb/terraform.tfstate)."
  }
}

variable "platform_state_region" {
  description = "Region of the S3 state bucket for platform-main"
  type        = string
  validation {
    condition     = length(trimspace(var.platform_state_region)) > 0
    error_message = "platform_state_region must be provided (see stage.tfvars)."
  }
}
