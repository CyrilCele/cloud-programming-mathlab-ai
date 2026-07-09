#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

source "$ROOT_DIR/tests/infrastructure/utils.sh"

###############################################################################
# Required Outputs
###############################################################################

require_output vpc_id
require_output internet_gateway_id
require_output alb_security_group_id
require_output ec2_security_group_id
require_output bucket_name
require_output alb_arn
require_output autoscaling_group_name
require_output distribution_id
require_output hosted_zone_id

###############################################################################
# Export Variables
###############################################################################

export VPC_ID="$(terraform_output vpc_id)"

export INTERNET_GATEWAY_ID="$(terraform_output internet_gateway_id)"

export ALB_SECURITY_GROUP_ID="$(terraform_output alb_security_group_id)"

export EC2_SECURITY_GROUP_ID="$(terraform_output ec2_security_group_id)"

export BUCKET_NAME="$(terraform_output bucket_name)"

export ALB_ARN="$(terraform_output alb_arn)"

export AUTOSCALING_GROUP_NAME="$(terraform_output autoscaling_group_name)"

export CLOUDFRONT_DISTRIBUTION_ID="$(terraform_output distribution_id)"

export ROUTE53_HOSTED_ZONE_ID="$(terraform_output hosted_zone_id)"