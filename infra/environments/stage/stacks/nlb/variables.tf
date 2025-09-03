variable "region" { type = string }
variable "env_name" { type = string }

variable "publish_to_ssm" {
  type    = bool
  default = true
}

variable "ssm_prefix" {
  type    = string
  default = "/idlms/nlb/stage"
}

# Optional: read NLB from another stack's state (S3 backend)
variable "use_remote_state" {
  type    = bool
  default = false
}

# Only needed if use_remote_state = true
variable "remote_state_bucket" {
  type    = string
  default = null
}
variable "remote_state_key" {
  type    = string
  default = null
}
variable "remote_state_region" {
  type    = string
  default = null
}
