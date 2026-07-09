DNS=$(
aws elbv2 describe-load-balancers \
    --load-balancer-arns "${ALB_ARN}" \
    --query "LoadBalancers[0].DNSName" \
    --output text
)

[[ -n "${DNS}" ]]

success "DNS name exists."

STATE=$(
aws elbv2 describe-load-balancers \
    --load-balancer-arns "${ALB_ARN}" \
    --query "LoadBalancers[0].State.Code" \
    --output text
)

[[ "${STATE}" == "active" ]]

success "Load Balancer active."