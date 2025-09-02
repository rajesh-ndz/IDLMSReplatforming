# Remote state for authoritative NLB data
data "terraform_remote_state" "nlb" {
  backend = "s3"
  config = {
    bucket = var.state_bucket
    key    = var.state_key
    region = var.state_region
  }
}

# Optional: read SSM maps written by platform-main for convenience
data "aws_ssm_parameter" "tg_map" { name = "${var.nlb_ssm_prefix}/target_group_arns" }
data "aws_ssm_parameter" "ls_map" { name = "${var.nlb_ssm_prefix}/listener_arns" }

locals {
  tg_map = try(jsondecode(data.aws_ssm_parameter.tg_map.value), {})
  ls_map = try(jsondecode(data.aws_ssm_parameter.ls_map.value), {})
}
