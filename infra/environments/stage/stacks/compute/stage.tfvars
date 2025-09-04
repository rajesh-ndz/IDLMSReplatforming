env_name = "stage"
region   = "ap-south-1"

remote_state_bucket      = "idlms-terraform-state-backend" # <- match your platform-main backend bucket
remote_state_region      = "ap-south-1"
remote_state_key_compute = "stage/compute/terraform.tfstate" # <- match your platform-main key exactly

publish_to_ssm = true
ssm_prefix     = "/idlms/compute/stage"
