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
    error_message = "Set vpc_link_id in <env>.tfvars (e.g., hda1q1)."
  }
}

# Platform (platform-main) remote state coordinates (for NLB)
variable "platform_state_bucket" {
  description = "S3 bucket holding platform-main state (e.g., idlms-terraform-state-backend)"
  type        = string
  validation {
    condition     = length(trimspace(var.platform_state_bucket)) > 0
    error_message = "platform_state_bucket must be provided (see stage.tfvars)."
  }
}

variable "platform_nlb_state_key" {
  description = "Key in the platform state bucket to the NLB state (e.g., stage/container/nlb/terraform.tfstate)"
  type        = string
  validation {
    condition     = length(trimspace(var.platform_nlb_state_key)) > 0
    error_message = "platform_nlb_state_key must be provided (see stage.tfvars)."
  }
}

variable "platform_state_region" {
  description = "Region of the platform state bucket (e.g., ap-south-1)"
  type        = string
  validation {
    condition     = length(trimspace(var.platform_state_region)) > 0
    error_message = "platform_state_region must be provided (see stage.tfvars)."
  }
}
