#!/usr/bin/env bash

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TERRAFORM_DIR="${PROJECT_ROOT}/terraform/environments/production"

cd "${TERRAFORM_DIR}"

echo "Running Terraform format check..."

terraform fmt -recursive

echo ""
echo "Running Terraform validation..."

terraform validate

echo ""
echo "Generating Terraform execution plan..."

terraform plan