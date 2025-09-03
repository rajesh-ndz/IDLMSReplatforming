terraform {
  required_version = ">= 1.5.0"
  backend "s3" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

# Use the same region you read the platform state from (safe default)
provider "aws" {
  region = var.platform_state_region
}
