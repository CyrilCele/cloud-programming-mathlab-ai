#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/outputs.sh"

info "Checking bucket..."

aws s3api head-bucket \
    --bucket "${BUCKET_NAME}"

success "Bucket exists."

###############################################################################
# Versioning
###############################################################################

STATUS=$(
aws s3api get-bucket-versioning \
    --bucket "${BUCKET_NAME}" \
    --query Status \
    --output text
)

[[ "${STATUS}" == "Enabled" ]]

success "Versioning enabled."

###############################################################################
# Encryption
###############################################################################

aws s3api get-bucket-encryption \
    --bucket "${BUCKET_NAME}" \
    >/dev/null

success "Encryption enabled."

###############################################################################
# Public Access Block
###############################################################################

PUBLIC=$(
aws s3api get-public-access-block \
    --bucket "${BUCKET_NAME}" \
    --query "PublicAccessBlockConfiguration.BlockPublicAcls" \
    --output text
)

[[ "${PUBLIC}" == "True" ]]

success "Public Access Block enabled."