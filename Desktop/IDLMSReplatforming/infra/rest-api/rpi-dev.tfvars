region               = "eu-west-1"
environment          = "rpi-dev"
stage_name           = "rpi-dev-idlms"
log_retention_days   = 7
api_description      = "Stage REST API to NLB"
binary_media_types   = ["*/*"]

common_tags = {
  Environment = "rpi-dev"
  Project     = "idlms"
  Owner       = "idlms-api"
}
throttling_rate_limit  = 300
throttling_burst_limit = 800
metrics_enabled      = true
logging_level        = "INFO"
data_trace_enabled   = false

api_port = 4000
tf_state_bucket  = "rpi-dev-btl-idlms-backend-api-tfstate-756718255547"
tf_state_region  = "eu-west-1"
