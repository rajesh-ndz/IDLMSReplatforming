data "aws_caller_identity" "current" {}

locals {
  artifact_bucket = "idlms-stage-website-built-artifact-${data.aws_caller_identity.current.account_id}"
  ec2_role_arn    = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/stage-ec2-ssm-role"
}

resource "aws_s3_bucket_policy" "artifact_policy" {
  bucket = local.artifact_bucket

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      # Keep any existing statements you have...
      {
        Sid : "AllowStageEc2Read",
        Effect : "Allow",
        Principal : { AWS : local.ec2_role_arn },
        Action : ["s3:GetObject"],
        Resource : "arn:aws:s3:::${local.artifact_bucket}/stage/*"
      },
      {
        Sid : "AllowStageEc2ListStagePrefix",
        Effect : "Allow",
        Principal : { AWS : local.ec2_role_arn },
        Action : ["s3:ListBucket"],
        Resource : "arn:aws:s3:::${local.artifact_bucket}",
        Condition : { StringLike : { "s3:prefix" : ["stage/*"] } }
      }
    ]
  })
}
