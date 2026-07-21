#!/usr/bin/env bash

set -euo pipefail

ENVIRONMENT="${ENVIRONMENT:-production}"

TF_DIR="terraform/environments/${ENVIRONMENT}"

echo ""
echo "Destroy AWS Infrastructure"
echo ""

read -rp "Continue? (yes/no): " CONFIRM

if [[ "$CONFIRM" != "yes" ]]; then
    echo "Cancelled."
    exit 0
fi

terraform -chdir="${TF_DIR}" destroy