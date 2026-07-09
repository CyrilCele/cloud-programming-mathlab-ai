#!/usr/bin/env bash

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

echo "========================================="
echo "MathLab AI Bootstrap"
echo "========================================="

echo
echo "Checking prerequisites..."

command -v git >/dev/null \
    || { echo "Git is not installed."; exit 1; }

command -v terraform >/dev/null \
    || { echo "Terraform is not installed."; exit 1; }

command -v aws >/dev/null \
    || { echo "AWS CLI is not installed."; exit 1; }

command -v zip >/dev/null \
    || { echo "zip is not installed."; exit 1; }

echo
echo "Checking AWS credentials..."

aws sts get-caller-identity >/dev/null

echo "AWS authentication successful."

mkdir -p "${PROJECT_ROOT}/build"

echo
echo "Initializing Terraform..."

terraform -chdir="${PROJECT_ROOT}/terraform/environments/production" init

echo
echo "Bootstrap completed successfully."