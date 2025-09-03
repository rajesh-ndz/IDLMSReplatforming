env = "stage"

# platform-main remote state (NLB)
platform_state_bucket  = "idlms-terraform-state-backend"
platform_nlb_state_key = "stage/container/nlb/terraform.tfstate"
platform_state_region  = "ap-south-1"

# reuse existing VPC link
vpc_link_id = "hda1q1"
