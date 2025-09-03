variable "env" {
  description = "Environment name (e.g., dev|stage|prod)"
  type        = string
}

variable "vpc_link_id" {
  description = "Existing API Gateway VPC Link ID (e.g., hda1q1)"
  type        = string
}

variable "platform_state_bucket" {
  description = "S3 bucket that holds platform-main NLB state"
  type        = string
}

variable "platform_nlb_state_key" {
  description = "Object key for platform-main NLB state (e.g., stage/container/nlb/terraform.tfstate)"
  type        = string
}

variable "platform_state_region" {
  description = "Region of the platform-main state bucket"
  type        = string
}
