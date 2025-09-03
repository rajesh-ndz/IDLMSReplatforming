variable "env" {
  description = "Environment (e.g., dev|stage|prod)"
  type        = string
}

# Optional – if you want the “idlms-<env>-website-built-artifact-<account_id>” pattern
data "aws_caller_identity" "current" {}
variable "prefix" {
  description = "Name prefix for bucket (defaults to idlms)"
  type        = string
  default     = "idlms"
}
