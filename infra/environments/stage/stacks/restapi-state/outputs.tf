output "rest_api_id"      { value = data.terraform_remote_state.rest.outputs.rest_api_id }
output "invoke_url"       { value = data.terraform_remote_state.rest.outputs.invoke_url }
output "vpc_link_id"      { value = try(data.terraform_remote_state.rest.outputs.vpc_link_id, null) }
output "access_log_group" { value = try(data.terraform_remote_state.rest.outputs.access_log_group, null) }
output "stage_name"       { value = try(data.terraform_remote_state.rest.outputs.stage_name, null) }
