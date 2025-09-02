terraform {
  backend "s3" {
    bucket  = "idlms-terraform-state-backend"
    key     = "stage/remote/ssm-state/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}
