#!/usr/bin/env bash

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WEBSITE_DIR="${PROJECT_ROOT}/website"
OUTPUT_DIR="${PROJECT_ROOT}/assets"

ARCHIVE_NAME="website.zip"

echo "Packaging website..."

rm -f "${OUTPUT_DIR}/${ARCHIVE_NAME}"

cd "${WEBSITE_DIR}"

zip -r "${OUTPUT_DIR}/${ARCHIVE_NAME}" .

echo ""
echo "Website package created:"
echo "${OUTPUT_DIR}/${ARCHIVE_NAME}"