#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/utils.sh"

section "Repository Structure"

FILES=(
    README.md
    CHANGELOG.md
    LICENSE
    SECURITY.md
    CONTRIBUTING.md
    CODE_OF_CONDUCT.md
    .gitignore
)

for FILE in "${FILES[@]}"; do
    require_file "${PROJECT_ROOT}/${FILE}"
done