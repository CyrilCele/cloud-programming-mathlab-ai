#!/usr/bin/env bash

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

BUCKET=$(terraform -chdir="${PROJECT_ROOT}/terraform/environments/production" output -raw bucket_name)

aws s3 cp \
    "${PROJECT_ROOT}/build/website.zip" \
    "s3://${BUCKET}/website.zip"