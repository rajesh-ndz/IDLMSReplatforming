variable "region"        { type = string }
variable "env_name"      { type = string }
variable "publish_to_ssm" {
  type    = bool
  default = true
}
variable "ssm_prefix" {
  type    = string
  default = "/idlms/nlb/stage"
}

# New: disable remote-state usage by default
variable "use_remote_state" {
  type    = bool
  default = false
}
