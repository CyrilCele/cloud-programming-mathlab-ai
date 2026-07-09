#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/utils.sh"

section "Markdown Validation"

if command -v markdownlint >/dev/null
then
    markdownlint ../../
    pass "Markdown lint"
else
    warning "markdownlint not installed"
fi