module "api" {
  source         = "../../../../platform/app/rest-api"
  region         = var.region
  env_name       = var.env_name
  enabled        = var.enabled
  nlb_ssm_prefix = var.nlb_ssm_prefix
  port           = var.port
}
output "rest_api_id" { value = module.api.rest_api_id }
output "invoke_url" { value = module.api.invoke_url }
output "stage_name" { value = module.api.stage_name }
