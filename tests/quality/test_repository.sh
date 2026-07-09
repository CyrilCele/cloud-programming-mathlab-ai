#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/utils.sh"

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

for FILE in "${FILES[@]}"
do
    if [[ -f "../../${FILE}" ]]; then
        pass "${FILE}"
    else
        fail "${FILE}"
    fi
done