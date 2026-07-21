#!/usr/bin/env bash

set -euo pipefail

################################################################################
# Configuration
################################################################################

REQUIRED_TERRAFORM_VERSION="1.13.0"
REQUIRED_AWS_MAJOR_VERSION="2"

################################################################################
# Helpers
################################################################################

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

check_command() {
    if command_exists "$1"; then
        printf "✓ %-18s installed\n" "$1"
    else
        printf "✗ %-18s missing\n" "$1"
        exit 1
    fi
}

################################################################################
# Required Commands
################################################################################

echo ""
echo "Checking required software..."
echo ""

check_command terraform
check_command aws
check_command git
check_command curl
check_command unzip

################################################################################
# Terraform Version
################################################################################

TF_VERSION=$(terraform version -json | awk -F'"' '/terraform_version/ {print $4}')

echo ""
echo "Terraform Version : ${TF_VERSION}"

################################################################################
# AWS CLI Version
################################################################################

AWS_VERSION=$(aws --version | awk '{print $1}' | cut -d/ -f2)

echo "AWS CLI Version  : ${AWS_VERSION}"

################################################################################
# AWS Authentication
################################################################################

echo ""
echo "Checking AWS credentials..."

ACCOUNT_ID=$(aws sts get-caller-identity \
    --query Account \
    --output text)

USER_ARN=$(aws sts get-caller-identity \
    --query Arn \
    --output text)

echo "✓ Account : ${ACCOUNT_ID}"
echo "✓ Identity: ${USER_ARN}"

################################################################################
# Region
################################################################################

AWS_REGION=$(aws configure get region)

if [[ -z "${AWS_REGION}" ]]; then
    echo ""
    echo "AWS region is not configured."
    exit 1
fi

echo "✓ Region  : ${AWS_REGION}"

################################################################################
# Finished
################################################################################

echo ""
echo "Environment validation completed successfully."