terraform {
  backend "s3" {
    bucket  = "idlms-terraform-state-backend"
    key     = "stage/remote/cw-state/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}
