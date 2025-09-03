variable "region"   { type = string }
variable "env_name" { type = string }
variable "enabled"  { type = bool default = false }
variable "dashboard_name" { type = string default = "" }
variable "nlb_arn"        { type = string }
variable "instance_id"    { type = string }
variable "docker_log_group_name" { type = string default = "/idlms/app/docker" }
variable "retention_days" { type = number default = 14 }
