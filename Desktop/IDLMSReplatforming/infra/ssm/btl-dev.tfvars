environment = "btl-dev"
region = "eu-west-1"
ssm_param_name         = "/idlms/shared/btl-dev/.env"
ssm_param_description  = "Shared environment variables for IDLMS in btl-dev"
ssm_param_app_tag      = "idlms"
app_env_content         = <<EOF
PORT=4000
PORT1=4001
PORT2=4002
DB_HOST=db.rpi-dev.internal
DB_USER=admin
DB_PASSWORD=supersecret
EOF
