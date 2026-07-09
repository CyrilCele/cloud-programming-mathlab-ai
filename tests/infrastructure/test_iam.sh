#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/utils.sh"

ROLE=$(terraform output -raw ec2_role_name)

info "Checking IAM Role..."

aws iam get-role \
    --role-name "$ROLE" \
    >/dev/null

success "IAM Role exists."