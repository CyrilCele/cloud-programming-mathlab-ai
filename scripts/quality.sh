#!/usr/bin/env bash

set -euo pipefail

echo ""
echo "Terraform Formatting..."
terraform fmt -recursive

echo ""
echo "Terraform Validation..."
make validate

echo ""
echo "Terraform Lint..."
make lint

echo ""
echo "Terraform Security..."
make security

echo ""
echo "Quality checks completed successfully."