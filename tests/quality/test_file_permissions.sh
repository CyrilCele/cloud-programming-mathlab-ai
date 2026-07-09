#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/utils.sh"

section "File Permissions"

###############################################################################
# Shell Scripts
###############################################################################

while IFS= read -r FILE
do
    if [[ -r "$FILE" ]]; then
        pass "Readable: ${FILE}"
    else
        fail "Readable: ${FILE}"
    fi

done < <(find ../../ -type f -name "*.sh")

###############################################################################
# Terraform Files
###############################################################################

while IFS= read -r FILE
do
    if [[ -r "$FILE" ]]; then
        pass "Readable: ${FILE}"
    else
        fail "Readable: ${FILE}"
    fi

done < <(find ../../ -type f -name "*.tf")

###############################################################################
# Markdown Files
###############################################################################

while IFS= read -r FILE
do
    if [[ -r "$FILE" ]]; then
        pass "Readable: ${FILE}"
    else
        fail "Readable: ${FILE}"
    fi

done < <(find ../../ -type f -name "*.md")

###############################################################################
# Template Files
###############################################################################

while IFS= read -r FILE
do
    if [[ -r "$FILE" ]]; then
        pass "Readable: ${FILE}"
    else
        fail "Readable: ${FILE}"
    fi

done < <(find ../../ -type f -name "*.tftpl")

###############################################################################
# Sensitive Files
###############################################################################

if [[ -f ../../terraform.tfstate ]]; then
    warning "terraform.tfstate detected in repository root."
fi

if [[ -f ../../terraform.tfstate.backup ]]; then
    warning "terraform.tfstate.backup detected in repository root."
fi

if find ../../ -type f -name "*.pem" | grep -q .; then
    warning "Private key (.pem) files detected."
fi

if find ../../ -type f -name "*.key" | grep -q .; then
    warning "Private key (.key) files detected."
fi

if find ../../ -type f -name "*.p12" | grep -q .; then
    warning "Certificate (.p12) files detected."
fi

if find ../../ -type f -name "*.jks" | grep -q .; then
    warning "Java keystore (.jks) files detected."
fi