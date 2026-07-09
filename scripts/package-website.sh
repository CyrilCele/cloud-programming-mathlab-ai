#!/usr/bin/env bash

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

BUILD_DIR="${PROJECT_ROOT}/build"

mkdir -p "${BUILD_DIR}"

rm -f "${BUILD_DIR}/website.zip"

cd "${PROJECT_ROOT}/website"

zip -r \
    "${BUILD_DIR}/website.zip" \
    .