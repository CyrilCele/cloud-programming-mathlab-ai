#!/usr/bin/env bash

require_file() {

    if [[ -f "$1" ]]; then
        pass "$1"
    else
        fail "$1"
    fi
}

require_directory() {

    if [[ -d "$1" ]]; then
        pass "$1"
    else
        fail "$1"
    fi
}

require_command() {

    if command -v "$1" >/dev/null 2>&1; then
        pass "$1 installed"
    else
        fail "$1 missing"
    fi
}

assert_not_empty() {

    local file="$1"

    if [[ ! -f "$file" ]]; then
        fail "$file does not exist"
        return 1
    fi

    if [[ ! -s "$file" ]]; then
        fail "$file is empty"
        return 1
    fi

    pass "$file"
}