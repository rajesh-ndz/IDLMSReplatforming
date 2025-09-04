variable "env_name" { type = string }
variable "region" { type = string }

variable "remote_state_bucket" { type = string }
variable "remote_state_region" { type = string }
variable "remote_state_key_compute" { type = string }

variable "publish_to_ssm" {
  type    = bool
  default = false
}

variable "ssm_prefix" {
  type    = string
  default = "/idlms/compute/stage"
}
