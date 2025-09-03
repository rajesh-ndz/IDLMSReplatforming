#!/usr/bin/env bash
set -euo pipefail

echo ">> Rewriting single-line variable blocks to multi-line…"
# Fix common one-line blocks across the repo (preserve defaults)
find infra -type f -name '*.tf' -print0 | xargs -0 sed -i -E \
  -e 's/variable "enabled"[[:space:]]*{[[:space:]]*type[[:space:]]*=[[:space:]]*bool[[:space:]]*default[[:space:]]*=[[:space:]]*false[[:space:]]*}/variable "enabled" {\n  type    = bool\n  default = false\n}/g' \
  -e 's/variable "publish_to_ssm"[[:space:]]*{[[:space:]]*type[[:space:]]*=[[:space:]]*bool[[:space:]]*default[[:space:]]*=[[:space:]]*true[[:space:]]*}/variable "publish_to_ssm" {\n  type    = bool\n  default = true\n}/g' \
  -e 's/variable "overwrite"[[:space:]]*{[[:space:]]*type[[:space:]]*=[[:space:]]*bool[[:space:]]*default[[:space:]]*=[[:space:]]*true[[:space:]]*}/variable "overwrite" {\n  type    = bool\n  default = true\n}/g' \
  -e 's/variable "dashboard_name"[[:space:]]*{[[:space:]]*type[[:space:]]*=[[:space:]]*string[[:space:]]*default[[:space:]]*=[[:space:]]*"([^"]*)"[[:space:]]*}/variable "dashboard_name" {\n  type    = string\n  default = "\1"\n}/g' \
  -e 's/variable "ssm_prefix"[[:space:]]*{[[:space:]]*type[[:space:]]*=[[:space:]]*string[[:space:]]*default[[:space:]]*=[[:space:]]*"([^"]*)"[[:space:]]*}/variable "ssm_prefix" {\n  type    = string\n  default = "\1"\n}/g'

echo ">> Making old-infra *.tfvars syntactically valid (so fmt/validate stop complaining)…"
# Convert the old templates to valid example tfvars
mkdir -p old-infra/cloudwatch old-infra/ecr old-infra/s3

cat > old-infra/cloudwatch/templates.tfvars <<'HCL'
# Example values (template)
environment    = "stage"
region         = "ap-south-1"
dashboard_name = "idlms-stage-dashboard"
HCL

cat > old-infra/ecr/templates.tfvars <<'HCL'
# Example values (template)
environment         = "stage"
region              = "ap-south-1"
repository_names    = ["idlms-api"]
image_tag_mutability = "IMMUTABLE"
scan_on_push        = true
HCL

cat > old-infra/s3/template.tfvars <<'HCL'
# Example values (template)
environment        = "stage"
region             = "ap-south-1"
bucket_name        = "idlms-stage-example-bucket-123456"
enable_versioning  = true
enable_encryption  = true
HCL

echo ">> terraform fmt -recursive"
terraform fmt -recursive

echo ">> Done."
