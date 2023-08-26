To deploy the module in the dev environment

terraform plan -var-file=environment/dev.tfvars
terraform apply --auto-approve -var-file environment/dev.tfvars

To destroy
terraform destroy --auto-approve -var-file environment/dev.tfvars