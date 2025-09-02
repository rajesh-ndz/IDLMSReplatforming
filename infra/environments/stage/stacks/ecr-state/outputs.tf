output "repository_names" { value = data.terraform_remote_state.ecr.outputs.repository_names }
output "repository_urls"  { value = data.terraform_remote_state.ecr.outputs.repository_urls }
output "repository_arns"  { value = data.terraform_remote_state.ecr.outputs.repository_arns }
