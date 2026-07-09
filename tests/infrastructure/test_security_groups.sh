info "Checking ALB HTTP rule..."

HTTP=$(
aws ec2 describe-security-groups \
    --group-ids "${ALB_SECURITY_GROUP_ID}" \
    --query "SecurityGroups[0].IpPermissions[?FromPort==\`80\`]"
)

[[ "${HTTP}" != "[]" ]]

success "HTTP rule verified."

info "Checking HTTPS rule..."

HTTPS=$(
aws ec2 describe-security-groups \
    --group-ids "${ALB_SECURITY_GROUP_ID}" \
    --query "SecurityGroups[0].IpPermissions[?FromPort==\`443\`]"
)

[[ "${HTTPS}" != "[]" ]]

success "HTTPS rule verified."