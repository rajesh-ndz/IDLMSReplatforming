# Optional, safe check (top-level). It references variables *inside* asserts.
check "inputs" {
  assert {
    condition     = length(trimspace(var.env)) > 0
    error_message = "env must not be empty."
  }
  assert {
    condition     = length(trimspace(var.vpc_link_id)) > 0
    error_message = "vpc_link_id must not be empty."
  }
}
