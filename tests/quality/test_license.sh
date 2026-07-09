#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/utils.sh"

section "License"

if [[ -f ../../LICENSE ]]
then
    pass "LICENSE exists"
else
    fail "LICENSE missing"
fi