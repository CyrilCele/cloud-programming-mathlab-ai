#!/usr/bin/env bash

set -euo pipefail

echo "Removing Terraform cache..."

find . -type d -name ".terraform" -exec rm -rf {} +

find . -name ".terraform.lock.hcl" -delete

find . -name "*.tfplan" -delete

find . -name "*.backup" -delete

echo "Cleanup complete."