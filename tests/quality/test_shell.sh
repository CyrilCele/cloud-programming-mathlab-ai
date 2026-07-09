#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/utils.sh"

# Fallback in case PROJECT_ROOT isn't defined globally yet
if [[ -z "${PROJECT_ROOT:-}" ]]; then
    PROJECT_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
fi

section "Shell Script Validation"

if command -v shellcheck >/dev/null; then

    # Find shell scripts safely inside the project root, skipping noise
    while IFS= read -r FILE
    do
        if shellcheck "$FILE"; then
            pass "Shellcheck passed: ${FILE#$PROJECT_ROOT/}"
        else
            fail "Shellcheck failed: ${FILE#$PROJECT_ROOT/}"
        fi
    done < <(find "$PROJECT_ROOT" -type d \( -name "venv" -o -name ".venv" -o -name ".git" -o -name "node_modules" -o -name ".terraform" \) -prune -o -type f -name "*.sh" -print)

else
    warning "shellcheck not installed"
fi
