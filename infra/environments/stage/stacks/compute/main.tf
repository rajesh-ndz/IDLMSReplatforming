module "compute_state" {
  source = "../../../../platform/remote/compute_state"
  bucket = "idlms-terraform-state-backend"
  key    = "stage/compute/terraform.tfstate"
  region = "ap-south-1"
}
module "publish" {
  count       = var.publish_to_ssm ? 1 : 0
  source      = "../../../../platform/app/ssm_publish"
  region      = var.region
  path_prefix = var.ssm_prefix
  values = {
    instance_id         = module.compute_state.instance_id
    instance_private_ip = module.compute_state.instance_private_ip
    security_group_id   = module.compute_state.security_group_id
  }
}
output "instance_id" { value = module.compute_state.instance_id }
output "instance_private_ip" { value = module.compute_state.instance_private_ip }
output "security_group_id" { value = module.compute_state.security_group_id }
output "published" { value = try(module.publish[0].published, []) }
