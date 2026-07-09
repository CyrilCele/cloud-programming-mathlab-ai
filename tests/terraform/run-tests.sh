#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "${SCRIPT_DIR}/utils.sh"

info "=========================================="
info "Terraform Validation Test Suite"
info "=========================================="

bash "${SCRIPT_DIR}/test_fmt.sh"

bash "${SCRIPT_DIR}/test_validate.sh"

bash "${SCRIPT_DIR}/test_plan.sh"

success "=========================================="
success "All Terraform tests passed successfully."
success "=========================================="