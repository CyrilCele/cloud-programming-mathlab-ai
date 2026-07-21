#!/usr/bin/env bash

set -euo pipefail

################################################################################
# Configuration
################################################################################

ENVIRONMENT="${ENVIRONMENT:-production}"

TF_DIR="terraform/environments/${ENVIRONMENT}"

################################################################################
# Prerequisites
################################################################################

./scripts/prerequisites.sh

################################################################################
# Terraform
################################################################################

echo ""
echo "Initializing Terraform..."

terraform -chdir="${TF_DIR}" init

echo ""
echo "Formatting Terraform..."

terraform -chdir="${TF_DIR}" fmt

echo ""
echo "Validating Terraform..."

terraform -chdir="${TF_DIR}" validate

echo ""
echo "Planning..."

terraform -chdir="${TF_DIR}" plan \
    -out=tfplan

echo ""
echo "Applying Infrastructure..."

terraform -chdir="${TF_DIR}" apply \
    tfplan

################################################################################
# Verification
################################################################################

./scripts/verify.sh