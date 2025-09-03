module "compute" {
  source = "../../../../platform/remote/compute_state"
  bucket = "idlms-terraform-state-backend"
  key    = "stage/compute/terraform.tfstate"
  region = "ap-south-1"
}
module "nlb" {
  source = "../../../../platform/remote/nlb_state"
  bucket = "idlms-terraform-state-backend"
  key    = "stage/nlb/terraform.tfstate"
  region = "ap-south-1"
}
module "cw" {
  source   = "../../../../platform/app/cloudwatch"
  region   = var.region
  env_name = var.env_name
  enabled  = var.enabled
  dashboard_name = "IDLMS-${var.env_name}"
  nlb_arn       = module.nlb.lb_arn
  instance_id   = module.compute.instance_id
}
output "dashboard_name"   { value = module.cw.dashboard_name }
output "docker_log_group" { value = module.cw.log_group_name }
