# We don't create a VPC Link here because the platform NLB is already
# attached to a VPC Endpoint Service. We must reuse the existing VPC Link.
variable "vpc_link_id" {
  description = "Existing API Gateway VPC Link ID to reuse (e.g., hda1q1)"
  type        = string
}
