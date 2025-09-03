locals {
  account_id  = data.aws_caller_identity.current.account_id
  bucket_name = "${var.prefix}-${var.env}-website-built-artifact-${local.account_id}"
}

resource "aws_s3_bucket" "artifact" {
  bucket        = local.bucket_name
  force_destroy = true

  tags = {
    Name        = "IDLMS ${var.env} Artifact Bucket"
    Environment = var.env
  }
}

resource "aws_s3_bucket_versioning" "artifact" {
  bucket = aws_s3_bucket.artifact.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "artifact" {
  bucket = aws_s3_bucket.artifact.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "artifact" {
  bucket                  = aws_s3_bucket.artifact.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
