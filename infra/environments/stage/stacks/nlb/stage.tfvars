env_name    = "stage"
region      = "ap-south-1"
nlb_name    = "stage-stage-nlb"
target_port = 4000

# FILL THIS IN with your app's PRIVATE IP in the NLB VPC
# e.g., "10.10.10.123"
target_ip = "None"

tags = {
  Project = "IDLMS"
  Env     = "stage"
  Owner   = "Rajesh.R"
}
