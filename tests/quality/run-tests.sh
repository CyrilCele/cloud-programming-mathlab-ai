#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

cd "$SCRIPT_DIR"

source "${SCRIPT_DIR}/utils.sh"

set -euo pipefail

section "Repository Quality Tests"

bash "${SCRIPT_DIR}/test_repository.sh"
bash "${SCRIPT_DIR}/test_directory_structure.sh"
bash "${SCRIPT_DIR}/test_markdown.sh"
bash "${SCRIPT_DIR}/test_shell.sh"
bash "${SCRIPT_DIR}/test_documentation.sh"
bash "${SCRIPT_DIR}/test_file_permissions.sh"
bash "${SCRIPT_DIR}/test_versions.sh"
bash "${SCRIPT_DIR}/test_gitignore.sh"
bash "${SCRIPT_DIR}/test_license.sh"

report