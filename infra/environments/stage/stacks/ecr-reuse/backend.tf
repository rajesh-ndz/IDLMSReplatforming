terraform {
  backend "s3" {
    bucket = "idlms-terraform-state-backend"
    key    = "IDLMSReplatforming/stage/stacks/ecr-reuse/terraform.tfstate"
    region = "ap-south-1"
    encrypt = true
  }
}
