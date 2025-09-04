variable "env_name" {
  type    = string
  default = "stage"
}

variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "nlb_name" {
  type    = string
  default = "stage-stage-nlb"
}

variable "target_port" {
  type    = number
  default = 4000
}

# Private IP of your app instance (in the NLB's VPC)
variable "target_ip" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {
    Project = "IDLMS"
    Env     = "stage"
    Owner   = "Rajesh.R"
  }
}
