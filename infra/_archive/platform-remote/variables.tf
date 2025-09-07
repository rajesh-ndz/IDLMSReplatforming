variable "region" {
  type    = string
  default = "ap-south-1"
}
variable "tf_state_bucket" {
  type = string
}
variable "network_state_key" {
  type    = string
  default = "stage/network/terraform.tfstate"
}
variable "compute_state_key" {
  type    = string
  default = "stage/compute/terraform.tfstate"
}
variable "ecr_state_key" {
  type    = string
  default = "stage/ecr/terraform.tfstate"
}
variable "nlb_state_key" {
  type    = string
  default = "stage/nlb/terraform.tfstate"
}
variable "rest_api_state_key" {
  type    = string
  default = "stage/rest-api/terraform.tfstate"
}
