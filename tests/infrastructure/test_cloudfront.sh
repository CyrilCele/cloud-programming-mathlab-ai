STATUS=$(
aws cloudfront get-distribution \
    --id "${CLOUDFRONT_DISTRIBUTION_ID}" \
    --query "Distribution.Status" \
    --output text
)

[[ "${STATUS}" == "Deployed" ]]

success "CloudFront deployed."

ROOT=$(
aws cloudfront get-distribution \
    --id "${CLOUDFRONT_DISTRIBUTION_ID}" \
    --query "Distribution.DistributionConfig.DefaultRootObject" \
    --output text
)

[[ "${ROOT}" == "index.html" ]]

success "Default root object verified."