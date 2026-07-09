#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/utils.sh"

section "Directory Structure"

DIRECTORIES=(
    terraform
    website
    docs
    scripts
    tests
    .github
)

for DIR in "${DIRECTORIES[@]}"
do
    require_directory "${PROJECT_ROOT}/${DIR}"
done