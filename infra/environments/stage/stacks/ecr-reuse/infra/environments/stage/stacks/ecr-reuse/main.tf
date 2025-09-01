module "platform_ecr" {
  source = "../../../../../modules/platform-ecr-reuse"

  platform_state_bucket  = var.platform_state_bucket
  platform_state_region  = var.platform_state_region
  platform_ecr_state_key = var.platform_ecr_state_key
}
