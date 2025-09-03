terraform {
  backend "s3" {
    bucket   = "idlms-terraform-state-backend"
    key      = "idlms/stage/cloudwatch/terraform.tfstate"
    region   = "ap-south-1"
    encrypt  = true
    # use_lockfile = true   # (Terraform >= 1.9). For older versions, add: dynamodb_table = "idlms-terraform-locks"
  }
}
