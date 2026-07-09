#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/utils.sh"

DIRECTORIES=(
terraform
website
docs
scripts
tests
.github
)

section "Directory Structure"

for DIR in "${DIRECTORIES[@]}"
do
    if [[ -d "../../${DIR}" ]]; then
        pass "${DIR}"
    else
        fail "${DIR}"
    fi
done