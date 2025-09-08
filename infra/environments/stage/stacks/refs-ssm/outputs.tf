output "file" {
  value = "${path.module}/../../../../refs/${var.env}.outputs.json"
}

output "ecr_repo_url" {
  value = nonsensitive(local.refs.ecr_repo_url)
}

output "instance_id" {
  value = nonsensitive(local.refs.instance_id)
}

output "tg_arn_4000" {
  value = nonsensitive(local.refs.tg_arn_4000)
}

output "apigw_invoke_url" {
  value = nonsensitive(local.refs.apigw_invoke_url)
}
