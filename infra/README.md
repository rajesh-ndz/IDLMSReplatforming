# IDLMSReplatforming: REUSE platform-main resources (apply per stack)

Stacks read **platform-main** state (network/compute/nlb/ecr) and publish to SSM (optional). Optional app stacks are disabled by default.

Run example:
  cd infra/environments/stage/stacks/network
  terraform init -reconfigure -upgrade
  terraform plan -var-file=stage.tfvars -out=plan.out
  terraform apply "plan.out"
