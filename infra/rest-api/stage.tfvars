env = "stage"

# platform-main remote state (NLB)
platform_state_bucket  = "idlms-terraform-state-backend"
platform_nlb_state_key = "stage/container/nlb/terraform.tfstate"
platform_state_region  = "ap-south-1"

# Reuse the existing VPC Link
vpc_link_id = "hda1q1"
