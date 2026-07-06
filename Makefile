fmt:
	cd terraform/environments/production && terraform fmt -recursive

validate:
	cd terraform/environments/production && terraform init
	cd terraform/environments/production && terraform validate

plan:
	cd terraform/environments/production && terraform plan

apply:
	cd terraform/environments/production && terraform apply

destroy:
	cd terraform/environments/production && terraform destroy