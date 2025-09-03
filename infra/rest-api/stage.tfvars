
# ===== platform-main remote state (stage) =====
platform_state_bucket  = "idlms-terraform-state-backend"
platform_nlb_state_key = "stage/container/nlb/terraform.tfstate"
platform_state_region  = "ap-south-1"

# environment for rest-api
env = "stage"

# Reuse the existing VPC Link (do not create a new one)
vpc_link_id = "hda1q1"
