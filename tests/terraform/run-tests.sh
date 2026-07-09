#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
TF_DIR="$ROOT_DIR/terraform/environments/production"

echo "[INFO] =========================================="
echo "[INFO] Terraform Validation Test Suite"
echo "[INFO] =========================================="

cd "$TF_DIR"

echo "[INFO] Running terraform fmt..."
terraform fmt -recursive -check
echo "[PASS] Terraform formatting validation passed."

echo "[INFO] Running terraform validate..."
terraform validate
echo "[PASS] Terraform validation passed."

echo "[INFO] Terraform syntax validation completed."
echo "[PASS] All Terraform validation tests passed."