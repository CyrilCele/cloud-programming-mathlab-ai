################################################################################
# Project Configuration
################################################################################

SHELL := /bin/bash

ENV ?= production
TF_DIR := terraform/environments/$(ENV)

TERRAFORM := terraform
AWS := aws

################################################################################
# Help
################################################################################

.DEFAULT_GOAL := help

help:
	@echo ""
	@echo "AWS Terraform Infrastructure"
	@echo ""
	@echo "Usage:"
	@echo "  make init"
	@echo "  make fmt"
	@echo "  make validate"
	@echo "  make plan"
	@echo "  make apply"
	@echo "  make verify"
	@echo "  make destroy"
	@echo "  make clean"
	@echo ""

################################################################################
# Dependency Checks
################################################################################

check:
	@command -v $(TERRAFORM) >/dev/null || (echo "Terraform not installed." && exit 1)
	@command -v $(AWS) >/dev/null || (echo "AWS CLI not installed." && exit 1)

	@terraform version
	@aws --version

################################################################################
# Terraform
################################################################################

init: check
	cd $(TF_DIR) && terraform init

fmt:
	cd terraform && terraform fmt -recursive

validate: init
	cd $(TF_DIR) && terraform validate

plan: validate
	cd $(TF_DIR) && terraform plan

apply: validate
	cd $(TF_DIR) && terraform apply

destroy: validate
	cd $(TF_DIR) && terraform destroy

################################################################################
# Verification
################################################################################

verify:
	./scripts/verify.sh

################################################################################
# Cleanup
################################################################################

clean:
	find . -type d -name ".terraform" -exec rm -rf {} +
	find . -name ".terraform.lock.hcl" -delete
	find . -name "*.tfplan" -delete

################################################################################
# Scripts
################################################################################

prerequisites:
	./scripts/prerequisites.sh

deploy:
	./scripts/deploy.sh

verify:
	./scripts/verify.sh

destroy:
	./scripts/destroy.sh

cleanup:
	./scripts/cleanup.sh