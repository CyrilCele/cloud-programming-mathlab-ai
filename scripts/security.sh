#!/usr/bin/env bash

set -euo pipefail

echo "Running security validation..."

if command -v tfsec >/dev/null; then
    tfsec terraform/
fi

if command -v checkov >/dev/null; then
    checkov -d terraform/
fi