data "aws_caller_identity" "me" {}

locals {
  ecr_param      = "${var.ssm_prefix}/ecr/${var.env}/repo_url"
  instance_param = "${var.ssm_prefix}/compute/${var.env}/instance_id"
  tg_param       = "${var.ssm_prefix}/nlb/${var.env}/tg_4000"
  apigw_param    = "${var.ssm_prefix}/rest-api/${var.env}/invoke_url"

  # path.module = infra/environments/stage/stacks/refs-ssm
  # ../../../../ -> infra
  out_path = "${path.module}/../../../../refs/${var.env}.outputs.json"
}

# Required params
data "aws_ssm_parameter" "ecr" {
  name            = local.ecr_param
  with_decryption = false
}

data "aws_ssm_parameter" "instance" {
  name            = local.instance_param
  with_decryption = false
}

# Optional params: use count to avoid failing if missing
data "aws_ssm_parameter" "tg" {
  count           = var.read_tg ? 1 : 0
  name            = local.tg_param
  with_decryption = false
}

data "aws_ssm_parameter" "apigw" {
  count           = var.read_apigw ? 1 : 0
  name            = local.apigw_param
  with_decryption = false
}

locals {
  refs = {
    env              = var.env
    region           = var.region
    account_id       = data.aws_caller_identity.me.account_id
    ecr_repo_url     = data.aws_ssm_parameter.ecr.value
    instance_id      = data.aws_ssm_parameter.instance.value
    tg_arn_4000      = var.read_tg    && length(data.aws_ssm_parameter.tg)    > 0 ? data.aws_ssm_parameter.tg[0].value    : null
    apigw_invoke_url = var.read_apigw && length(data.aws_ssm_parameter.apigw) > 0 ? data.aws_ssm_parameter.apigw[0].value : null
    notes            = "Generated from SSM; update SSM if infra changes."
  }
}

# Ensure destination dir exists before writing file
resource "null_resource" "ensure_out_dir" {
  provisioner "local-exec" {
    command = "mkdir -p ${dirname(local.out_path)}"
  }
}

resource "local_file" "outputs" {
  filename   = local.out_path
  content    = jsonencode(local.refs)
  depends_on = [null_resource.ensure_out_dir]
}
