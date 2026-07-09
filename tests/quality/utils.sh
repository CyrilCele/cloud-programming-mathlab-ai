#!/usr/bin/env bash

set -euo pipefail

###############################################################################
# Colours
###############################################################################

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
NC="\033[0m"

###############################################################################
# Test Counters
###############################################################################

TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

START_TIME=$(date +%s)

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

    echo -e "${BLUE}[INFO]${NC} $1"
}

pass() {

    ((TESTS_RUN++))
    ((TESTS_PASSED++))

    echo -e "${GREEN}[PASS]${NC} $1"
}

fail() {

    ((TESTS_RUN++))
    ((TESTS_FAILED++))

    echo -e "${RED}[FAIL]${NC} $1"
}

warning() {

    echo -e "${YELLOW}[WARN]${NC} $1"
}

abort() {

    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

###############################################################################
# Assertions
###############################################################################

assert_exists() {

    local path="$1"
    local description="$2"

    if [[ -e "$path" ]]; then
        pass "$description"
    else
        fail "$description"
    fi
}

assert_file() {

    local path="$1"
    local description="$2"

    if [[ -f "$path" ]]; then
        pass "$description"
    else
        fail "$description"
    fi
}

assert_directory() {

    local path="$1"
    local description="$2"

    if [[ -d "$path" ]]; then
        pass "$description"
    else
        fail "$description"
    fi
}

assert_not_empty() {

    local value="$1"
    local description="$2"

    if [[ -n "$value" ]]; then
        pass "$description"
    else
        fail "$description"
    fi
}

assert_equals() {

    local expected="$1"
    local actual="$2"
    local description="$3"

    if [[ "$expected" == "$actual" ]]; then
        pass "$description"
    else
        fail "$description"

        echo "Expected : $expected"
        echo "Actual   : $actual"
    fi
}

###############################################################################
# Report
###############################################################################

report() {

    END_TIME=$(date +%s)

    DURATION=$((END_TIME - START_TIME))

    echo
    echo "======================================================"
    echo "Repository Quality Test Report"
    echo "======================================================"
    echo

    printf "%-20s %s\n" "Tests Run:" "$TESTS_RUN"
    printf "%-20s %s\n" "Passed:" "$TESTS_PASSED"
    printf "%-20s %s\n" "Failed:" "$TESTS_FAILED"
    printf "%-20s %ss\n" "Duration:" "$DURATION"

    echo

    if [[ "$TESTS_FAILED" -eq 0 ]]; then

        echo -e "${GREEN}Repository quality validation PASSED.${NC}"

        exit 0

    else

        echo -e "${RED}Repository quality validation FAILED.${NC}"

        exit 1

    fi
}