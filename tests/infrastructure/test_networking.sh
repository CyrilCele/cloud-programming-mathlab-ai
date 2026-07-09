#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/outputs.sh"

info "Validating VPC..."

aws ec2 describe-vpcs \
    --vpc-ids "${VPC_ID}" \
    >/dev/null

CIDR=$(
aws ec2 describe-vpcs \
    --vpc-ids "${VPC_ID}" \
    --query "Vpcs[0].CidrBlock" \
    --output text
)

[[ "${CIDR}" == "10.0.0.0/16" ]]

success "VPC CIDR validated."

DNS_SUPPORT=$(
aws ec2 describe-vpcs \
    --vpc-ids "${VPC_ID}" \
    --query "Vpcs[0].EnableDnsSupport.Value" \
    --output text
)

[[ "${DNS_SUPPORT}" == "True" ]]

success "DNS Support enabled."

DNS_HOSTNAMES=$(
aws ec2 describe-vpcs \
    --vpc-ids "${VPC_ID}" \
    --query "Vpcs[0].EnableDnsHostnames.Value" \
    --output text
)

[[ "${DNS_HOSTNAMES}" == "True" ]]

success "DNS Hostnames enabled."