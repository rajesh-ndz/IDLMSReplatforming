output "vpc_id"                 { value = try(data.terraform_remote_state.network.outputs.vpc_id, null) }
output "public_subnet_ids"      { value = try(data.terraform_remote_state.network.outputs.public_subnet_ids, []) }
output "private_subnet_ids"     { value = try(data.terraform_remote_state.network.outputs.private_subnet_ids, []) }

output "ecr_repository_url"     { value = try(data.terraform_remote_state.ecr.outputs.ecr_repository_url, null) }

output "compute_instance_id"    { value = try(data.terraform_remote_state.compute.outputs.instance_id, null) }

output "nlb_dns_name"           { value = try(data.terraform_remote_state.nlb.outputs.nlb_dns_name, null) }
output "nlb_zone_id"            { value = try(data.terraform_remote_state.nlb.outputs.nlb_zone_id, null) }
output "listener_4000"          { value = try(data.terraform_remote_state.nlb.outputs.listener_4000, null) }
output "tg_4000"                { value = try(data.terraform_remote_state.nlb.outputs.tg_4000, null) }

output "apigw_invoke_url"       { value = try(data.terraform_remote_state.rest_api.outputs.invoke_url, null) }
output "apigw_stage_name"       { value = try(data.terraform_remote_state.rest_api.outputs.stage_name, null) }
