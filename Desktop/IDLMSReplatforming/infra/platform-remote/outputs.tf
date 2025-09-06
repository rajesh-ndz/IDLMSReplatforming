# Network
output "vpc_id"              { value = data.terraform_remote_state.network.outputs.vpc_id }
output "public_subnet_ids"   { value = data.terraform_remote_state.network.outputs.public_subnet_ids }
output "private_subnet_ids"  { value = data.terraform_remote_state.network.outputs.private_subnet_ids }

# Compute
output "compute_instance_id" { value = try(data.terraform_remote_state.compute.outputs.instance_id, null) }

# NLB
output "nlb_dns_name"        { value = data.terraform_remote_state.nlb.outputs.lb_dns_name }
output "nlb_zone_id"         { value = data.terraform_remote_state.nlb.outputs.lb_zone_id }
output "listener_4000"       { value = try(data.terraform_remote_state.nlb.outputs.listener_arns["4000"], null) }
output "tg_4000"             { value = try(data.terraform_remote_state.nlb.outputs.target_group_arns["4000"], null) }

# ECR
output "ecr_repository_url"  { value = try(data.terraform_remote_state.ecr.outputs.repository_urls[0], null) }

# API Gateway (if present)
output "apigw_invoke_url"    { value = try(data.terraform_remote_state.rest_api.outputs.invoke_url, null) }
output "apigw_stage_name"    { value = try(data.terraform_remote_state.rest_api.outputs.stage_name, null) }
