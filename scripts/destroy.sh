#!/usr/bin/env bash

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TERRAFORM_DIR="${PROJECT_ROOT}/terraform/environments/production"

cd "${TERRAFORM_DIR}"

echo "WARNING"
echo "This operation will destroy all managed infrastructure."

read -rp "Continue? (yes/no): " CONFIRM

if [[ "${CONFIRM}" != "yes" ]]; then
    echo "Operation cancelled."
    exit 0
fi

terraform destroy