COUNT=$(
aws route53 list-resource-record-sets \
    --hosted-zone-id "${ROUTE53_HOSTED_ZONE_ID}" \
    --query "length(ResourceRecordSets)"
)

[[ "${COUNT}" -gt 0 ]]

success "DNS records exist."