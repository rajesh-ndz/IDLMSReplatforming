data "aws_ssm_parameter" "lb_arn"      { name = "${var.nlb_ssm_prefix}/lb_arn" }
data "aws_ssm_parameter" "lb_dns_name" { name = "${var.nlb_ssm_prefix}/lb_dns_name" }
data "aws_ssm_parameter" "lb_zone_id"  { name = "${var.nlb_ssm_prefix}/lb_zone_id" }

data "aws_ssm_parameter" "listener_arns"     { name = "${var.nlb_ssm_prefix}/listener_arns" }
data "aws_ssm_parameter" "target_group_arns" { name = "${var.nlb_ssm_prefix}/target_group_arns" }

locals {
  ls_map = jsondecode(data.aws_ssm_parameter.listener_arns.value)
  tg_map = jsondecode(data.aws_ssm_parameter.target_group_arns.value)
}
