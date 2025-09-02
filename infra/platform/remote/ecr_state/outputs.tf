output "repository_names" { value = try(data.terraform_remote_state.ecr.outputs.repository_names, []) }
output "repository_urls"  { value = try(data.terraform_remote_state.ecr.outputs.repository_urls,  []) }
output "repository_arns"  { value = try(data.terraform_remote_state.ecr.outputs.repository_arns,  []) }
