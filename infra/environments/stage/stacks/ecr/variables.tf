variable "env_name" { type = string }
variable "region"   { type = string }
variable "publish_to_ssm" { type = bool default = true }
variable "ssm_prefix"     { type = string default = "/idlms/ecr/stage" }
