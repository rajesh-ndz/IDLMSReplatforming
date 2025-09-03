output "vpc_id"             { value = data.terraform_remote_state.network.outputs.vpc_id }
output "public_subnet_ids"  { value = data.terraform_remote_state.network.outputs.public_subnet_ids }
output "private_subnet_ids" { value = data.terraform_remote_state.network.outputs.private_subnet_ids }
