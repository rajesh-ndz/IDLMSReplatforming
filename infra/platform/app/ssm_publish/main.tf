locals { prefix = trimsuffix(var.path_prefix, "/") }
resource "aws_ssm_parameter" "params" {
  for_each    = var.values
  name        = "${local.prefix}/${each.key}"
  type        = "String"
  value       = each.value
  overwrite   = var.overwrite
  description = "IDLMS reuse value ${each.key}"
}
