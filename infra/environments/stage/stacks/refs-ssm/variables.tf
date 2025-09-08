variable "env" {
  type = string
}

variable "region" {
  type = string
}

variable "ssm_prefix" {
  type    = string
  default = "/idlms"
}

variable "read_tg" {
  type    = bool
  default = true
}

variable "read_apigw" {
  type    = bool
  default = true
}
