#!/usr/bin/env bash

set -euo pipefail

terraform fmt -recursive -check

if command -v shellcheck >/dev/null; then
    find . -name "*.sh" -exec shellcheck {} +
fi

if command -v markdownlint >/dev/null; then
    markdownlint .
fi