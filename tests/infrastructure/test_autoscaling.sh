DESIRED=$(
aws autoscaling describe-auto-scaling-groups \
    --auto-scaling-group-names "${AUTOSCALING_GROUP_NAME}" \
    --query "AutoScalingGroups[0].DesiredCapacity" \
    --output text
)

[[ "${DESIRED}" == "2" ]]

success "Desired capacity verified."

MIN=$(
aws autoscaling describe-auto-scaling-groups \
    --auto-scaling-group-names "${AUTOSCALING_GROUP_NAME}" \
    --query "AutoScalingGroups[0].MinSize" \
    --output text
)

[[ "${MIN}" == "2" ]]

success "Minimum capacity verified."

MAX=$(
aws autoscaling describe-auto-scaling-groups \
    --auto-scaling-group-names "${AUTOSCALING_GROUP_NAME}" \
    --query "AutoScalingGroups[0].MaxSize" \
    --output text
)

[[ "${MAX}" == "4" ]]

success "Maximum capacity verified."