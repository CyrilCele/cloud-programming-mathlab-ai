#!/usr/bin/env bash

set -euo pipefail

find . -type d -name ".terraform" -exec rm -rf {} +

find . -type f -name "*.tfplan" -delete

find . -type f -name "*.log" -delete

rm -rf build