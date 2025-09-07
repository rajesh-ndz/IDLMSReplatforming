output "artifact_bucket_name" {
  value = nonsensitive(data.aws_ssm_parameter.bucket_name.value)
}
output "artifact_default_key" {
  value = nonsensitive(data.aws_ssm_parameter.default_key.value)
}
