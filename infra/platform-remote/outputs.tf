# Network
output "vpc_id"              { value = try(data.terraform_remote_state.network.outputs.vpc_id, null) }
output "private_subnet_ids"  { value = try(data.terraform_remote_state.network.outputs.private_subnet_ids, []) }
output "public_subnet_ids"   { value = try(data.terraform_remote_state.network.outputs.public_subnet_ids, []) }

# Compute
output "instance_id"         { value = try(data.terraform_remote_state.compute.outputs.instance_id, null) }
output "instance_private_ip" { value = try(data.terraform_remote_state.compute.outputs.instance_private_ip, null) }
output "security_group_id"   { value = try(data.terraform_remote_state.compute.outputs.security_group_id, null) }

# NLB
output "lb_arn"              { value = try(data.terraform_remote_state.nlb.outputs.lb_arn, null) }
output "lb_dns_name"         { value = try(data.terraform_remote_state.nlb.outputs.lb_dns_name, null) }
# uncomment below if your nlb module outputs tg_4000 by name
# output "tg_4000"          { value = try(data.terraform_remote_state.nlb.outputs.tg_4000, null) }

# ECR (first repo)
output "ecr_repository_url"  { value = try(data.terraform_remote_state.ecr.outputs.repository_urls[0], null) }
output "ecr_repository_name" { value = try(data.terraform_remote_state.ecr.outputs.repository_names[0], null) }

# API Gateway
output "apigw_invoke_url"    { value = try(data.terraform_remote_state.rest_api.outputs.invoke_url, null) }
output "apigw_stage_name"    { value = try(data.terraform_remote_state.rest_api.outputs.stage_name, null) }
