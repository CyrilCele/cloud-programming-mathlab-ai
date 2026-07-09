#!/usr/bin/env bash

set -euo pipefail

###############################################################################
# Paths
###############################################################################

TEST_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROJECT_ROOT="$(cd "${TEST_ROOT}/.." && pwd)"
TF_ROOT="${PROJECT_ROOT}/terraform/environments/production"

###############################################################################
# Logging
###############################################################################

section() {
    echo
    echo "======================================================"
    echo "$1"
    echo "======================================================"
}

info() {
    echo "[INFO] $1"
}

pass() {
    echo "[PASS] $1"
    PASS_COUNT=$((PASS_COUNT + 1))
}

fail() {
    echo "[FAIL] $1"
    FAIL_COUNT=$((FAIL_COUNT + 1))
}

###############################################################################
# Assertions
###############################################################################

require_file() {

    local file="$1"

    if [[ -f "$file" ]]; then
        pass "$file"
    else
        fail "$file"
    fi
}

require_directory() {

    local dir="$1"

    if [[ -d "$dir" ]]; then
        pass "$dir"
    else
        fail "$dir"
    fi
}

require_command() {

    local cmd="$1"

    if command -v "$cmd" >/dev/null 2>&1; then
        pass "$cmd"
    else
        fail "$cmd"
    fi
}
###############################################################################
# Terraform Helpers
###############################################################################

terraform_validate() {

    (
        cd "$TF_ROOT"

        terraform validate
    )

}

terraform_fmt() {

    (
        cd "$TF_ROOT"

        terraform fmt -recursive -check
    )

}

terraform_output() {

    (
        cd "$TF_ROOT"

        terraform output -raw "$1"
    )

}

terraform_state_exists() {

    (
        cd "$TF_ROOT"

        terraform state list >/dev/null 2>&1
    )

}

require_output() {

    local output="$1"

    (
        cd "$TF_ROOT"

        terraform output "$output" >/dev/null 2>&1
    )

    if [[ $? -eq 0 ]]; then
        pass "Terraform output '${output}'"
    else
        fail "Terraform output '${output}'"
    fi
}

###############################################################################
# Summary
###############################################################################

report() {

    echo
    echo "======================================================"
    echo "Summary"
    echo "======================================================"

    echo "Passed : ${PASS_COUNT}"
    echo "Failed : ${FAIL_COUNT}"

    if [[ ${FAIL_COUNT} -gt 0 ]]; then
        exit 1
    fi

    echo
    echo "All tests completed successfully."
}

###############################################################################
# Warning
###############################################################################

warning() {
    echo "[WARNING] $1"
}