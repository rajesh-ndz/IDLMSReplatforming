locals { do = var.enabled }
resource "aws_cloudwatch_log_group" "app" {
  count             = local.do ? 1 : 0
  name              = var.docker_log_group_name
  retention_in_days = var.retention_days
  tags              = { Environment = var.env_name, Project = "IDLMS" }
}
resource "aws_cloudwatch_dashboard" "this" {
  count          = local.do ? 1 : 0
  dashboard_name = var.dashboard_name != "" ? var.dashboard_name : "IDLMS-${var.env_name}"
  dashboard_body = jsonencode({
    widgets = [
      { "type" : "metric", "x" : 0, "y" : 0, "width" : 12, "height" : 6,
        "properties" : { "metrics" : [["AWS/EC2", "CPUUtilization", "InstanceId", var.instance_id]], "period" : 60, "stat" : "Average", "title" : "EC2 CPU" }
      },
      { "type" : "metric", "x" : 12, "y" : 0, "width" : 12, "height" : 6,
        "properties" : { "metrics" : [["AWS/NetworkELB", "ActiveFlowCount", "LoadBalancer", var.nlb_arn]], "period" : 60, "stat" : "Sum", "title" : "NLB Flows" }
      }
    ]
  })
}
