env_name = "stage"
region   = "ap-south-1"

nlb_ssm_prefix = "/idlms/nlb/stage"
nlb_port       = 4000

publish_to_ssm     = true
restapi_ssm_prefix = "/idlms/rest-api/stage"

tags = {
  Project = "IDLMS"
  Env     = "stage"
  Owner   = "Rajesh.R"
}
