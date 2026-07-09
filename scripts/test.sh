#!/usr/bin/env bash

set -euo pipefail

echo "=========================================="
echo "MathLab AI Validation Pipeline"
echo "=========================================="

echo
echo "Running Repository Quality Tests..."
./tests/quality/run-tests.sh

echo
echo "Running Terraform Tests..."
./tests/terraform/run-tests.sh

echo
echo "Running Infrastructure Tests..."
./tests/infrastructure/run-tests.sh

echo
echo "=========================================="
echo "Validation Completed"
echo "=========================================="