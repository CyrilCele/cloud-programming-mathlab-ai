#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/utils.sh"

# Fallback in case PROJECT_ROOT isn't defined globally yet
if [[ -z "${PROJECT_ROOT:-}" ]]; then
    PROJECT_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
fi

section ".gitignore Validation"

GITIGNORE_FILE="$PROJECT_ROOT/.gitignore"

# Verify the file actually exists first
if [[ ! -f "$GITIGNORE_FILE" ]]; then
    fail ".gitignore file is missing from repository root!"
    exit 1
fi

# Safe pattern verification helper
check_ignore_rule() {
    local pattern="$1"
    local description="$2"
    
    if grep -q "$pattern" "$GITIGNORE_FILE"; then
        pass "$description ignored"
    else
        fail "Missing rule: $description ($pattern) is not ignored!"
    fi
}

###############################################################################
# Run Validation Rules
###############################################################################

check_ignore_rule ".terraform/" "Terraform internal cache"
check_ignore_rule "\*.tfstate" "Terraform state files"
check_ignore_rule "\*.tfplan" "Terraform plans"
