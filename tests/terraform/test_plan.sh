#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/utils.sh"

info "Running terraform plan..."

terraform plan -input=false -out=tfplan

success "Terraform execution plan generated successfully."