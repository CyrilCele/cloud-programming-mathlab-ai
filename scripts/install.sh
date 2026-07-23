#!/usr/bin/env bash

set -euo pipefail

################################################################################
# Configuration
################################################################################

REQUIRED_TERRAFORM_VERSION="1.13.0"

WINGET_COMMON_ARGS=(
    --exact
    --source winget
    --accept-package-agreements
    --accept-source-agreements
    --disable-interactivity
)

################################################################################
# Helpers
################################################################################

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

refresh_path() {
    export PATH="$PATH:/c/Program Files/Amazon/AWSCLIV2"
    export PATH="$PATH:/c/Program Files/Git/cmd"
    export PATH="$PATH:/c/Program Files/Git/bin"
    export PATH="$PATH:/c/Program Files/HashiCorp/Terraform"
    hash -r 2>/dev/null || true
}

install_with_winget() {
    local package_id="$1"
    local package_name="$2"
    shift 2

    echo ""
    echo "Installing ${package_name}..."

    winget.exe install \
        --id "$package_id" \
        "${WINGET_COMMON_ARGS[@]}" \
        "$@"
}

require_winget() {
    if command_exists winget.exe; then
        printf "✓ %-18s installed\n" "winget"
        return
    fi

    echo "✗ Windows Package Manager is not installed."
    echo ""
    echo "Install or update 'App Installer' from the Microsoft Store,"
    echo "then reopen Git Bash and run this script again."
    exit 1
}

################################################################################
# Platform Validation
################################################################################

echo ""
echo "Checking operating system..."
echo ""

case "${OSTYPE:-}" in
    msys*|cygwin*|win32*)
        printf "✓ %-18s detected\n" "Windows Git Bash"
        ;;
    *)
        echo "✗ This installer is intended for Windows Git Bash."
        echo "Detected OSTYPE: ${OSTYPE:-unknown}"
        exit 1
        ;;
esac

require_winget
refresh_path

################################################################################
# Git
################################################################################

if command_exists git; then
    printf "✓ %-18s already installed\n" "git"
else
    install_with_winget "Git.Git" "Git"
    refresh_path
fi

################################################################################
# curl
################################################################################

if command_exists curl; then
    printf "✓ %-18s already installed\n" "curl"
else
    install_with_winget "cURL.cURL" "curl"
    refresh_path
fi

################################################################################
# unzip
################################################################################

if command_exists unzip; then
    printf "✓ %-18s already installed\n" "unzip"
else
    echo ""
    echo "Installing unzip..."

    INSTALL_ROOT="${LOCALAPPDATA:-$HOME/AppData/Local}/mathlab-ai-tools"
    UNZIP_DIR="${INSTALL_ROOT}/unzip"
    UNZIP_ZIP="${TMPDIR:-/tmp}/unzip.zip"

    mkdir -p "$UNZIP_DIR"

    curl -fsSL \
        "https://downloads.sourceforge.net/gnuwin32/unzip-5.51-1-bin.zip" \
        -o "$UNZIP_ZIP"

    powershell.exe -NoProfile -NonInteractive -Command \
        "Expand-Archive -LiteralPath '$(cygpath -w "$UNZIP_ZIP")' \
        -DestinationPath '$(cygpath -w "$UNZIP_DIR")' -Force"

    rm -f "$UNZIP_ZIP"

    export PATH="$PATH:${UNZIP_DIR}/bin"
    hash -r 2>/dev/null || true

    if ! command_exists unzip; then
        echo "✗ unzip installation failed."
        exit 1
    fi
fi

################################################################################
# AWS CLI v2
################################################################################

if command_exists aws; then
    AWS_VERSION="$(aws --version 2>&1 | awk '{print $1}' | cut -d/ -f2)"

    if [[ "${AWS_VERSION%%.*}" == "2" ]]; then
        printf "✓ %-18s already installed (%s)\n" "AWS CLI" "$AWS_VERSION"
    else
        install_with_winget "Amazon.AWSCLI" "AWS CLI v2"
        refresh_path
    fi
else
    install_with_winget "Amazon.AWSCLI" "AWS CLI v2"
    refresh_path
fi

################################################################################
# Terraform
################################################################################

INSTALL_TERRAFORM=true

if command_exists terraform; then
    INSTALLED_TERRAFORM_VERSION="$(
        terraform version -json |
            awk -F'"' '/terraform_version/ {print $4; exit}'
    )"

    if [[ "$INSTALLED_TERRAFORM_VERSION" == "$REQUIRED_TERRAFORM_VERSION" ]]; then
        printf "✓ %-18s already installed (%s)\n" \
            "Terraform" \
            "$INSTALLED_TERRAFORM_VERSION"

        INSTALL_TERRAFORM=false
    fi
fi

if [[ "$INSTALL_TERRAFORM" == true ]]; then
    echo ""
    echo "Installing Terraform ${REQUIRED_TERRAFORM_VERSION}..."

    winget.exe install \
        --id Hashicorp.Terraform \
        --version "$REQUIRED_TERRAFORM_VERSION" \
        "${WINGET_COMMON_ARGS[@]}"

    refresh_path
fi

################################################################################
# Verification
################################################################################

echo ""
echo "Verifying installations..."
echo ""

refresh_path

MISSING=0

for command in terraform aws git curl unzip; do
    if command_exists "$command"; then
        printf "✓ %-18s installed\n" "$command"
    else
        printf "✗ %-18s unavailable in this shell\n" "$command"
        MISSING=1
    fi
done

if [[ "$MISSING" -ne 0 ]]; then
    echo ""
    echo "One or more commands were installed but are not yet visible."
    echo "Close Git Bash, reopen it, and run:"
    echo ""
    echo "bash scripts/prerequisites.sh"
    exit 1
fi

INSTALLED_TERRAFORM_VERSION="$(
    terraform version -json |
        awk -F'"' '/terraform_version/ {print $4; exit}'
)"

AWS_VERSION="$(
    aws --version 2>&1 |
        awk '{print $1}' |
        cut -d/ -f2
)"

if [[ "$INSTALLED_TERRAFORM_VERSION" != "$REQUIRED_TERRAFORM_VERSION" ]]; then
    echo ""
    echo "✗ Terraform version mismatch."
    echo "Required : ${REQUIRED_TERRAFORM_VERSION}"
    echo "Installed: ${INSTALLED_TERRAFORM_VERSION}"
    exit 1
fi

if [[ "${AWS_VERSION%%.*}" != "2" ]]; then
    echo ""
    echo "✗ AWS CLI v2 is required."
    echo "Installed version: ${AWS_VERSION}"
    exit 1
fi

echo ""
echo "Installed versions"
echo "------------------"
echo "Terraform : ${INSTALLED_TERRAFORM_VERSION}"
echo "AWS CLI   : ${AWS_VERSION}"
echo "Git       : $(git --version)"
echo "curl      : $(curl --version | head -n1)"
echo "unzip     : $(unzip -v | head -n1)"

echo ""
echo "Prerequisite installation completed successfully."
echo ""
echo "Run the following command to validate the environment:"
echo ""
echo "bash scripts/prerequisites.sh"