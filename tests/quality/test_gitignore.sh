#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/utils.sh"

section ".gitignore"

grep ".terraform/" ../../.gitignore >/dev/null

pass ".terraform ignored"

grep "*.tfstate" ../../.gitignore >/dev/null

pass "Terraform state ignored"

grep "*.tfplan" ../../.gitignore >/dev/null

pass "Terraform plans ignored"