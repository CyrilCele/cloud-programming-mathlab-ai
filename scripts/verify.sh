#!/usr/bin/env bash

set -euo pipefail

################################################################################
# Configuration
################################################################################

AWS_REGION="${AWS_REGION:-us-east-1}"
ENVIRONMENT="${ENVIRONMENT:-production}"

TF_DIR="terraform/environments/${ENVIRONMENT}"

echo ""
echo "============================================================"
echo "AWS Infrastructure Verification"
echo "============================================================"
echo ""

################################################################################
# Verify Terraform
################################################################################

echo "Checking Terraform..."

terraform version >/dev/null

echo "✓ Terraform installed"

################################################################################
# Verify AWS CLI
################################################################################

echo "Checking AWS CLI..."

aws --version >/dev/null

echo "✓ AWS CLI installed"

################################################################################
# Verify AWS Credentials
################################################################################

echo "Checking AWS Credentials..."

aws sts get-caller-identity >/dev/null

echo "✓ AWS credentials valid"

################################################################################
# Read Terraform Outputs
################################################################################

echo "Reading Terraform outputs..."

ALB_DNS=$(terraform -chdir="${TF_DIR}" output -raw alb_dns_name)
WEBSITE_URL=$(terraform -chdir="${TF_DIR}" output -raw website_url)
BUCKET=$(terraform -chdir="${TF_DIR}" output -raw assets_bucket_name)

echo "ALB: $ALB_DNS"
echo "Website: $WEBSITE_URL"
echo "Bucket: $BUCKET"

################################################################################
# Verify S3
################################################################################

echo ""
echo "Checking S3..."

aws s3 ls "s3://${BUCKET}" >/dev/null

echo "✓ Bucket accessible"

################################################################################
# Verify Website
################################################################################

echo ""
echo "Checking Website..."

HTTP_CODE=$(curl \
    --silent \
    --location \
    --output /dev/null \
    --write-out "%{http_code}" \
    "${WEBSITE_URL}")

if [[ "$HTTP_CODE" != "200" ]]; then
    echo "Website returned HTTP ${HTTP_CODE}"
    exit 1
fi

echo "✓ Website reachable"

################################################################################
# Verify HTTPS
################################################################################

echo ""
echo "Checking HTTPS..."

curl \
    --fail \
    --silent \
    --show-error \
    --head \
    --connect-timeout 5 \
    --max-time 10 \
    "${WEBSITE_URL}" >/dev/null

echo "✓ HTTPS working"

################################################################################
# Verify ALB
################################################################################

echo ""
echo "Checking ALB..."

ALB_ARN=$(aws elbv2 describe-load-balancers \
    --region "$AWS_REGION" \
    --query "LoadBalancers[?DNSName=='${ALB_DNS}'].LoadBalancerArn | [0]" \
    --output text)

if [[ -z "$ALB_ARN" || "$ALB_ARN" == "None" ]]; then
    echo "ALB not found for DNS name: ${ALB_DNS}"
    exit 1
fi

ALB_STATE=$(aws elbv2 describe-load-balancers \
    --region "$AWS_REGION" \
    --load-balancer-arns "$ALB_ARN" \
    --query "LoadBalancers[0].State.Code" \
    --output text)

if [[ "$ALB_STATE" != "active" ]]; then
    echo "ALB is not active. Current state: ${ALB_STATE}"
    exit 1
fi

echo "✓ ALB active"

################################################################################
# Verify Target Health
################################################################################

echo ""
echo "Checking Target Health..."

ALB_ARN=$(aws elbv2 describe-load-balancers \
    --names mathlab-ai-alb \
    --query 'LoadBalancers[0].LoadBalancerArn' \
    --output text)

TG_ARN=$(aws elbv2 describe-target-groups \
    --region "$AWS_REGION" \
    --load-balancer-arn "$ALB_ARN" \
    --query 'TargetGroups[0].TargetGroupArn' \
    --output text)

UNHEALTHY=$(aws elbv2 describe-target-health \
    --region "$AWS_REGION" \
    --target-group-arn "$TG_ARN" \
    --query "TargetHealthDescriptions[?TargetHealth.State!='healthy']" \
    --output json)

if [[ "$UNHEALTHY" != "[]" ]]; then
    echo "Unhealthy targets detected."
    exit 1
fi

echo "✓ Targets healthy"

################################################################################
# Finished
################################################################################

echo ""
echo "============================================================"
echo "Infrastructure verification completed successfully."
echo "============================================================"