module "network_state" {
  source = "../../../../platform/remote/network_state"
  bucket = "idlms-terraform-state-backend"
  key    = "stage/network/terraform.tfstate"
  region = "ap-south-1"
}
module "publish" {
  count       = var.publish_to_ssm ? 1 : 0
  source      = "../../../../platform/app/ssm_publish"
  region      = var.region
  path_prefix = var.ssm_prefix
  values = {
    vpc_id             = module.network_state.vpc_id
    public_subnet_ids  = jsonencode(module.network_state.public_subnet_ids)
    private_subnet_ids = jsonencode(module.network_state.private_subnet_ids)
  }
}
output "vpc_id"             { value = module.network_state.vpc_id }
output "public_subnet_ids"  { value = module.network_state.public_subnet_ids }
output "private_subnet_ids" { value = module.network_state.private_subnet_ids }
output "published"          { value = try(module.publish[0].published, []) }
