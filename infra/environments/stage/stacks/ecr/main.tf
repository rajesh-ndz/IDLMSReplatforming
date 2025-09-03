module "ecr_state" {
  source = "../../../../platform/remote/ecr_state"
  bucket = "idlms-terraform-state-backend"
  key    = "stage/ecr/terraform.tfstate"
  region = "ap-south-1"
}
module "publish" {
  count       = var.publish_to_ssm ? 1 : 0
  source      = "../../../../platform/app/ssm_publish"
  region      = var.region
  path_prefix = var.ssm_prefix
  values = {
    repository_names = jsonencode(module.ecr_state.repository_names)
    repository_urls  = jsonencode(module.ecr_state.repository_urls)
    repository_arns  = jsonencode(module.ecr_state.repository_arns)
  }
}
output "repository_names" { value = module.ecr_state.repository_names }
output "repository_urls" { value = module.ecr_state.repository_urls }
output "repository_arns" { value = module.ecr_state.repository_arns }
output "published" { value = try(module.publish[0].published, []) }
