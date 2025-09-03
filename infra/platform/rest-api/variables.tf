variable "region" { type = string }
variable "env_name" { type = string }

variable "enabled" {
  type    = bool
  default = false
}

variable "api_name" {
  type    = string
  default = "idlms-api"
}

variable "stage_name" {
  type    = string
  default = "stage"
}

variable "description" {
  type    = string
  default = "IDLMS REST API (reusing NLB)"
}

variable "nlb_ssm_prefix" { type = string }
variable "port"           { type = number }

variable "endpoint_type" {
  type    = string
  default = "REGIONAL"
}

variable "access_log_retention_days" {
  type    = number
  default = 14
}

variable "root_path" {
  type    = string
  default = ""
}
