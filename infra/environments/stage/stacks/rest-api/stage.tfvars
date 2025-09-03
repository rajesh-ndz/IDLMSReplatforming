region   = "ap-south-1"
env_name = "stage"
enabled  = true

api_name    = "idlms-api"
stage_name  = "stage"
description = "IDLMS REST API (reusing NLB)"

nlb_ssm_prefix = "/idlms/nlb/stage"
port           = 4000

endpoint_type             = "REGIONAL"
access_log_retention_days = 14

# Optional: if you want .../stage (root) to return health
root_path = "/health"
