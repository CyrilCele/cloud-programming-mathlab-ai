#!/usr/bin/env bash

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TERRAFORM_DIR="${PROJECT_ROOT}/terraform/environments/production"

echo "=================================================="
echo "AWS Static Website Infrastructure"
echo "Terraform Bootstrap"
echo "=================================================="

cd "${TERRAFORM_DIR}"

echo ""
echo "Initializing Terraform..."
terraform init

echo ""
echo "Terraform initialization completed successfully"