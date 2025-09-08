variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "repository_name" {
  type = string
}

variable "image_scanning_on_push" {
  type    = bool
  default = true
}

variable "force_delete" {
  type    = bool
  default = true
}
