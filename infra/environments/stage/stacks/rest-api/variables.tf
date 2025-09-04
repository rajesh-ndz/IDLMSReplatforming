variable "env_name" { type = string }
variable "region" { type = string }

# NLB info comes from SSM so we don't depend on remote state layout
variable "nlb_ssm_prefix" {
  type    = string
  default = "/idlms/nlb/stage"
}

# Port your app listens on behind the NLB
variable "nlb_port" {
  type    = number
  default = 4000
}

variable "publish_to_ssm" {
  type    = bool
  default = true
}

variable "restapi_ssm_prefix" {
  type    = string
  default = "/idlms/rest-api/stage"
}

variable "tags" {
  type = map(string)
  default = {
    "Project" = "IDLMS"
    "Env"     = "stage"
    "Owner"   = "Rajesh.R"
  }
}
