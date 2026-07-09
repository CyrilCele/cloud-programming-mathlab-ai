#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/utils.sh"

info "Running terraform fmt..."

terraform fmt -recursive -check

success "Terraform formatting validation passed."