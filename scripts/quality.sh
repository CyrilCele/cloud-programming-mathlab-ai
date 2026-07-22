#!/usr/bin/env bash

set -Eeuo pipefail

readonly ROOT_DIR="$(
  cd "$(dirname "${BASH_SOURCE[0]}")/.."
  pwd
)"
readonly TERRAFORM_DIR="${ROOT_DIR}/terraform"
readonly PRODUCTION_DIR="${TERRAFORM_DIR}/environments/production"

printf '\nTerraform Formatting...\n\n'
terraform fmt -check -recursive "${TERRAFORM_DIR}"

printf '\nTerraform Initialization...\n\n'
terraform \
  -chdir="${PRODUCTION_DIR}" \
  init \
  -backend=false \
  -input=false \
  -no-color

printf '\nTerraform Validation...\n\n'
terraform \
  -chdir="${PRODUCTION_DIR}" \
  validate \
  -no-color

printf '\nTFLint Initialization...\n\n'
tflint --init

printf '\nTFLint Validation...\n\n'
tflint --recursive

if command -v checkov >/dev/null 2>&1; then
  printf '\nCheckov Validation...\n\n'
  checkov \
    --directory "${TERRAFORM_DIR}" \
    --framework terraform \
    --compact
else
  printf '\nCheckov is not installed; skipping Checkov validation.\n'
fi

printf '\nAll quality checks passed.\n'
