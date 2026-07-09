#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/utils.sh"

section "Shell Script Validation"

if command -v shellcheck >/dev/null
then

    find ../../ -name "*.sh" |

    while read FILE
    do
        shellcheck "$FILE"
    done

    pass "Shell scripts"

else

    warning "shellcheck not installed"

fi