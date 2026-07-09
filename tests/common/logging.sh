#!/usr/bin/env bash

PASS_COUNT=0
FAIL_COUNT=0

section() {
    echo
    echo "======================================================"
    echo "$1"
    echo "======================================================"
}

pass() {
    echo "[PASS] $1"
    PASS_COUNT=$((PASS_COUNT + 1))
}

fail() {
    echo "[FAIL] $1"
    FAIL_COUNT=$((FAIL_COUNT + 1))
}

info() {
    echo "[INFO] $1"
}

report() {

    echo
    echo "======================================================"
    echo "Test Summary"
    echo "======================================================"

    echo "Passed : ${PASS_COUNT}"
    echo "Failed : ${FAIL_COUNT}"

    if [[ ${FAIL_COUNT} -gt 0 ]]; then
        exit 1
    fi

    echo
    echo "All tests passed."
}