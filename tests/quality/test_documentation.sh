#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/utils.sh"

section "Documentation"

MARKDOWN_COUNT=$(
find ../../ -name "*.md" | wc -l
)

assert_not_empty "$MARKDOWN_COUNT" \
"Documentation exists"

README_COUNT=$(
find ../../ -name "README.md" | wc -l
)

assert_not_empty "$README_COUNT" \
"README files found"