#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/utils.sh"

# Fallback in case PROJECT_ROOT isn't defined globally yet
if [[ -z "${PROJECT_ROOT:-}" ]]; then
    PROJECT_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
fi

section "File Permissions"

# A reusable finder function to skip virtual environments and hidden directories
find_project_files() {
    local ext="$1"
    find "$PROJECT_ROOT" \
        -type d \( -name "venv" -o -name ".venv" -o -name ".git" -o -name "node_modules" \) -prune \
        -o -type f -name "*.$ext" -print
}

###############################################################################
# Shell Scripts
###############################################################################
while IFS= read -r FILE
do
    if [[ -r "$FILE" ]]; then
        pass "Readable: ${FILE#$PROJECT_ROOT/}"
    else
        fail "Readable: ${FILE#$PROJECT_ROOT/}"
    fi
# FIX: The loop reads directly from the process instead of using a pipe
done < <(find "$PROJECT_ROOT" -type d \( -name "venv" -o -name ".venv" -o -name ".git" -o -name "node_modules" -o -name ".terraform" \) -prune -o -type f -name "*.sh" -print)


###############################################################################
# Terraform Files
###############################################################################
while IFS= read -r FILE
do
    if [[ -r "$FILE" ]]; then
        pass "Readable: ${FILE#$PROJECT_ROOT/}"
    else
        fail "Readable: ${FILE#$PROJECT_ROOT/}"
    fi
done < <(find "$PROJECT_ROOT" -type d \( -name "venv" -o -name ".venv" -o -name ".git" -o -name "node_modules" -o -name ".terraform" \) -prune -o -type f -name "*.tf" -print)


###############################################################################
# Markdown Files
###############################################################################
while IFS= read -r FILE
do
    if [[ -r "$FILE" ]]; then
        pass "Readable: ${FILE#$PROJECT_ROOT/}"
    else
        fail "Readable: ${FILE#$PROJECT_ROOT/}"
    fi
done < <(find "$PROJECT_ROOT" -type d \( -name "venv" -o -name ".venv" -o -name ".git" -o -name "node_modules" -o -name ".terraform" \) -prune -o -type f -name "*.md" -print)


###############################################################################
# Template Files
###############################################################################
while IFS= read -r FILE
do
    if [[ -r "$FILE" ]]; then
        pass "Readable: ${FILE#$PROJECT_ROOT/}"
    else
        fail "Readable: ${FILE#$PROJECT_ROOT/}"
    fi
done < <(find "$PROJECT_ROOT" -type d \( -name "venv" -o -name ".venv" -o -name ".git" -o -name "node_modules" -o -name ".terraform" \) -prune -o -type f -name "*.tftpl" -print)

###############################################################################
# Sensitive Files
###############################################################################

if [[ -f "$PROJECT_ROOT/terraform.tfstate" ]]; then
    warning "terraform.tfstate detected in repository root."
fi

if [[ -f "$PROJECT_ROOT/terraform.tfstate.backup" ]]; then
    warning "terraform.tfstate.backup detected in repository root."
fi

if find_project_files "pem" | grep -q .; then
    warning "Private key (.pem) files detected."
fi

if find_project_files "key" | grep -q .; then
    warning "Private key (.key) files detected."
fi

if find_project_files "p12" | grep -q .; then
    warning "Certificate (.p12) files detected."
fi

if find_project_files "jks" | grep -q .; then
    warning "Java keystore (.jks) files detected."
fi
