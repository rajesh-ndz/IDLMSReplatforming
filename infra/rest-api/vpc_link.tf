# We do NOT create a VPC Link here.
# We reuse an existing API Gateway VPC Link via var.vpc_link_id.
# Example in stage.tfvars:
#   vpc_link_id = "hda1q1"
