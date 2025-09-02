variable "state_bucket"  { type = string }
variable "state_key"     { type = string }
variable "state_region"  { type = string }
variable "nlb_ssm_prefix" {
  type    = string
  default = "/idlms/nlb/stage"
}
