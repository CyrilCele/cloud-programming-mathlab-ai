#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/utils.sh"

section "Version Checks"

terraform version >/dev/null

pass "Terraform installed"

aws --version >/dev/null

pass "AWS CLI installed"

git --version >/dev/null

pass "Git installed"