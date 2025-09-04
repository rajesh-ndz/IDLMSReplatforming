terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = ">= 5.0" }
  }
}

provider "aws" { region = var.region }

# Look up the EXISTING NLB by name (we won't recreate it)
data "aws_lb" "nlb" { name = var.nlb_name }

# Target group on :4000 using IP targets (robust even if instance IDs change)
resource "aws_lb_target_group" "app" {
  name        = "${var.env_name}-${var.nlb_name}-4000-ip"
  port        = var.target_port
  protocol    = "TCP"
  target_type = "ip"
  vpc_id      = data.aws_lb.nlb.vpc_id

  health_check {
    protocol = "TCP"
  }

  tags = var.tags
}

# Register your app's private IP on :4000
resource "aws_lb_target_group_attachment" "ip" {
  target_group_arn = aws_lb_target_group.app.arn
  target_id        = var.target_ip
  port             = var.target_port
}

# Listener :4000 → forward to the IP TG
resource "aws_lb_listener" "tcp_4000" {
  load_balancer_arn = data.aws_lb.nlb.arn
  port              = var.target_port
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }

  tags = var.tags
}

# Publish handy values to SSM for other stacks
resource "aws_ssm_parameter" "lb_arn" {
  name      = "/idlms/nlb/${var.env_name}/lb_arn"
  type      = "String"
  value     = data.aws_lb.nlb.arn
  overwrite = true
}

resource "aws_ssm_parameter" "lb_dns_name" {
  name      = "/idlms/nlb/${var.env_name}/lb_dns_name"
  type      = "String"
  value     = data.aws_lb.nlb.dns_name
  overwrite = true
}

resource "aws_ssm_parameter" "lb_zone_id" {
  name      = "/idlms/nlb/${var.env_name}/lb_zone_id"
  type      = "String"
  value     = data.aws_lb.nlb.zone_id
  overwrite = true
}

resource "aws_ssm_parameter" "listener_arns" {
  name      = "/idlms/nlb/${var.env_name}/listener_arns"
  type      = "StringList"
  value     = join(",", [aws_lb_listener.tcp_4000.arn])
  overwrite = true
}

resource "aws_ssm_parameter" "target_group_arns" {
  name      = "/idlms/nlb/${var.env_name}/target_group_arns"
  type      = "StringList"
  value     = join(",", [aws_lb_target_group.app.arn])
  overwrite = true
}

output "lb_arn" { value = data.aws_lb.nlb.arn }
output "lb_dns_name" { value = data.aws_lb.nlb.dns_name }
output "lb_zone_id" { value = data.aws_lb.nlb.zone_id }
output "listener_arn" { value = aws_lb_listener.tcp_4000.arn }
output "target_group_arn" { value = aws_lb_target_group.app.arn }
