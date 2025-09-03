variable "env_name" { type = string }
variable "region"   { type = string }
variable "enabled" {
  type    = bool
  default = false
}

variable "nlb_ssm_prefix" { type = string }
variable "port"     { type = number }
