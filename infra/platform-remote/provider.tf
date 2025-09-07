terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}
# Provider isn't strictly needed for terraform_remote_state, but harmless.
provider "aws" {
  region = var.region
}
