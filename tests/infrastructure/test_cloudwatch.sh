ALARMS=$(
aws cloudwatch describe-alarms \
    --query "length(MetricAlarms)"
)

[[ "${ALARMS}" -gt 0 ]]

success "CloudWatch alarms detected."