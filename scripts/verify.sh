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
    --silent \
    --head \
    "${WEBSITE_URL}" >/dev/null

echo "✓ HTTPS working"

################################################################################
# Verify ALB
################################################################################

echo ""
echo "Checking ALB..."

curl \
    --silent \
    --head \
    "http://${ALB_DNS}" >/dev/null

echo "✓ ALB reachable"

################################################################################
# Verify Target Health
################################################################################

echo ""
echo "Checking Target Health..."

TG_ARN=$(aws elbv2 describe-target-groups \
    --query "TargetGroups[0].TargetGroupArn" \
    --output text)

UNHEALTHY=$(aws elbv2 describe-target-health \
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