data "terraform_remote_state" "rest" {
  backend = "s3"
  config = {
    bucket = var.state_bucket
    key    = var.state_key
    region = var.state_region
  }
}
