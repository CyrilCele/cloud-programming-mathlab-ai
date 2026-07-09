#!/usr/bin/env bash

set -euo pipefail

echo "=========================================="
echo "MathLab AI Validation Pipeline"
echo "=========================================="

echo
echo "Running Terraform Tests..."
bash tests/terraform/run-tests.sh

echo
echo "Running Infrastructure Tests..."
bash tests/infrastructure/run-tests.sh

echo
echo "Running Repository Quality Tests..."
bash tests/quality/run-tests.sh

echo
echo "=========================================="
echo "All validation suites completed."
echo "=========================================="