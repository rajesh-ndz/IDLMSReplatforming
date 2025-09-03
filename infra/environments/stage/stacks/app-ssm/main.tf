module "ssm" {
  source      = "../../../../platform/app/ssm_publish"
  region      = var.region
  path_prefix = var.path_prefix
  values      = var.values
}
output "published" { value = module.ssm.published }
