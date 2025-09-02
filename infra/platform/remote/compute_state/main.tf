data "terraform_remote_state" "compute" {
  backend = "s3"
  config = {
    bucket = var.bucket
    key    = var.key
    region = var.region
  }
}
