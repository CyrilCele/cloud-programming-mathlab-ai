#!/usr/bin/env bash

LOG_DIR="logs"

mkdir -p "${LOG_DIR}"

LOG_FILE="${LOG_DIR}/$(date +%Y%m%d-%H%M%S).log"

exec > >(tee "${LOG_FILE}") 2>&1

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "${SCRIPT_DIR}/utils.sh"

if ! terraform_state_exists; then

    info "Terraform state not found."

    info "Skipping infrastructure validation."

    exit 0

fi

info "========================================="
info "Infrastructure Validation Test Suite"
info "========================================="

bash "${SCRIPT_DIR}/test_networking.sh"
bash "${SCRIPT_DIR}/test_security_groups.sh"
bash "${SCRIPT_DIR}/test_iam.sh"
bash "${SCRIPT_DIR}/test_s3.sh"
bash "${SCRIPT_DIR}/test_alb.sh"
bash "${SCRIPT_DIR}/test_autoscaling.sh"
bash "${SCRIPT_DIR}/test_cloudfront.sh"
bash "${SCRIPT_DIR}/test_route53.sh"
bash "${SCRIPT_DIR}/test_cloudwatch.sh"

success "========================================="
success "Infrastructure validation completed."
success "All tests passed successfully."
success "========================================="