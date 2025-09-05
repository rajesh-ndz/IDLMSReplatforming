terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws",
      version = ">= 5.0"
    }
  }
}

resource "aws_instance" "idlms_ec2" {
  ami                         = var.ami_id
  instance_type               = lookup(var.amis, var.aws_region)
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  vpc_security_group_ids      = var.security_group_ids
  iam_instance_profile        = var.instance_profile_name
  associate_public_ip_address = var.associate_public_ip_address

  tags = merge(var.ec2_tags, { Name = var.name })
}
