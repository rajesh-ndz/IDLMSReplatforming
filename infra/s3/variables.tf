variable "environment" {
  description = "Deployment environment (e.g., dev, stage, prod)"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "ssm_prefix" {
  description = "SSM path prefix where platform-main publishes the artifact bucket"
  type        = string
  default     = "/idlms/artifacts"
}
