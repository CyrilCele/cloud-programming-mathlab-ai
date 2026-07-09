#!/usr/bin/env bash

set -euo pipefail

TEST_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROJECT_ROOT="$(cd "${TEST_ROOT}/.." && pwd)"
TF_ROOT="${PROJECT_ROOT}/terraform/environments/production"