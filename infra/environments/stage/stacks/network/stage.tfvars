env_name = "stage"
region   = "ap-south-1"

remote_state_bucket      = "idlms-terraform-state-backend" # your platform-main backend bucket
remote_state_region      = "ap-south-1"
remote_state_key_network = "stage/network/terraform.tfstate" # match platform-main key exactly

publish_to_ssm = true
ssm_prefix     = "/idlms/network/stage"
