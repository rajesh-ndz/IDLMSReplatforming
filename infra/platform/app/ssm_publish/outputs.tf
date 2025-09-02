output "published" { value = [for k, v in aws_ssm_parameter.params : v.name] }
