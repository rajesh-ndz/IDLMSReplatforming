data "terraform_remote_state" "s3" {
  backend = "s3"
  config = {
    bucket = var.state_bucket
    key    = var.state_key
    region = var.state_region
  }
}
