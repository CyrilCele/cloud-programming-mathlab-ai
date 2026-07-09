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
# Counters
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

###############################################################################
# Assertions
###############################################################################

assert_equals() {

    local expected="$1"
    local actual="$2"
    local message="$3"

    if [[ "$expected" == "$actual" ]]; then
        pass "$message"
    else
        fail "$message"

        echo "Expected : $expected"
        echo "Actual   : $actual"
    fi
}

assert_not_empty() {

    local value="$1"
    local message="$2"

    if [[ -n "$value" ]]; then
        pass "$message"
    else
        fail "$message"
    fi
}

assert_true() {

    local condition="$1"
    local message="$2"

    if [[ "$condition" == "True" ]]; then
        pass "$message"
    else
        fail "$message"
    fi
}

###############################################################################
# AWS Helper
###############################################################################

aws_query() {

    aws "$@" --output text
}

###############################################################################
# Report
###############################################################################

report() {

END_TIME=$(date +%s)

DURATION=$((END_TIME-START_TIME))

echo
echo "======================================================"
echo "MathLab AI Infrastructure Test Report"
echo "======================================================"

echo

printf "%-20s %s\n" "Tests Run:" "$TESTS_RUN"

printf "%-20s %s\n" "Passed:" "$TESTS_PASSED"

printf "%-20s %s\n" "Failed:" "$TESTS_FAILED"

printf "%-20s %ss\n" "Duration:" "$DURATION"

echo

if [[ "$TESTS_FAILED" -eq 0 ]]; then

    echo -e "${GREEN}Infrastructure validation PASSED.${NC}"

    exit 0

else

    echo -e "${RED}Infrastructure validation FAILED.${NC}"

    exit 1

fi
}