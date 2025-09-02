# infra/environments/stage/stacks/compute-state/policy.tf

variable "environment" {
  type    = string
  default = "stage"
}

data "aws_caller_identity" "current" {}

# Look up your EC2 SSM role (adjust the name if yours differs)
data "aws_iam_role" "ec2_ssm_role" {
  name = "${var.environment}-ec2-ssm-role"
}

# 1) Allow the EC2 instance to pull from ECR
resource "aws_iam_role_policy_attachment" "ec2_ecr_readonly" {
  role       = data.aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# 2) Allow the instance to read your compose file from the artifacts S3 bucket
locals {
  artifact_bucket = "idlms-${var.environment}-website-built-artifact-${data.aws_caller_identity.current.account_id}"
  prefix          = "${var.environment}/*"
}

resource "aws_iam_role_policy" "ec2_artifacts_s3_read" {
  name = "S3ReadArtifacts-${var.environment}"
  role = data.aws_iam_role.ec2_ssm_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid : "ListEnvPrefix",
        Effect : "Allow",
        Action : ["s3:ListBucket"],
        Resource : "arn:aws:s3:::${local.artifact_bucket}",
        Condition : { StringLike : { "s3:prefix" : [local.prefix] } }
      },
      {
        Sid : "GetObjectsUnderEnv",
        Effect : "Allow",
        Action : ["s3:GetObject"],
        Resource : "arn:aws:s3:::${local.artifact_bucket}/${local.prefix}"
      }
    ]
  })
}

# If your bucket uses a KMS key, also allow decrypt:
# resource "aws_iam_role_policy" "ec2_artifacts_kms_decrypt" {
#   name = "ArtifactsKmsDecrypt-${var.environment}"
#   role = data.aws_iam_role.ec2_ssm_role.id
#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect: "Allow",
#       Action: ["kms:Decrypt", "kms:DescribeKey"],
#       Resource: "arn:aws:kms:ap-south-1:${data.aws_caller_identity.current.account_id}:key/<YOUR-KMS-KEY-ID>"
#     }]
#   })
# }
