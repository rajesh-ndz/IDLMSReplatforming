tf_state_bucket = "rpi-dev-btl-idlms-backend-api-tfstate-756718255547"
environment     = "rpi-dev"
region          = "eu-west-1"
tf_state_region  = "eu-west-1"
load_balancer_type = "network"
internal           = true
target_port        = 4000
lb_create_sg       = true
additional_ports = [4000, 4001, 4002]

lb_egress_roles = [
  {
    description      = "Allow all outbound"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    security_groups  = []
    self             = false
  }
]

common_tags = {
  Environment = "rpi-dev"
  Project     = "IDLMS"
}
ssm_param_name         = "/rpi-dev-cloudwatch/docker-config"
ssm_tag_name           = "rpi-dev-docker-cloudwatch-config"

