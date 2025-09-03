output "instance_id" { value = data.terraform_remote_state.compute.outputs.instance_id }
output "instance_private_ip" { value = data.terraform_remote_state.compute.outputs.instance_private_ip }
output "security_group_id" { value = data.terraform_remote_state.compute.outputs.security_group_id }
