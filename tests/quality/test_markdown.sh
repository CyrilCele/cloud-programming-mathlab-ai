#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/utils.sh"

section "Markdown Validation"

if command -v markdownlint >/dev/null 2>&1
then
    markdownlint "${PROJECT_ROOT}"
    pass "Markdown lint"
else
    warning "markdownlint is not installed. Skipping Markdown validation."
fi