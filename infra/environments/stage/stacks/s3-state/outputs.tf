output "bucket_name"           { value = data.terraform_remote_state.s3.outputs.bucket_name }
output "bucket_arn"            { value = data.terraform_remote_state.s3.outputs.bucket_arn }
output "ssm_bucket_name_param" { value = try(data.terraform_remote_state.s3.outputs.ssm_bucket_name_param, null) }
output "ssm_bucket_arn_param"  { value = try(data.terraform_remote_state.s3.outputs.ssm_bucket_arn_param,  null) }
