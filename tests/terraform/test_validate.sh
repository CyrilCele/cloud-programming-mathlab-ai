#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/utils.sh"

info "Running terraform validate..."

terraform validate

success "Terraform validation passed."