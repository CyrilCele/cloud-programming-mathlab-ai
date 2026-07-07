# IAM Module

## Purpose

This module provisions the AWS Identity and Access Management (IAM) resources required for Amazon EC2 instances.

## Resources

- IAM Role
- Customer Managed IAM Policy
- IAM Role Policy Attachment
- EC2 Instance Profile

## Design

The module follows the Principle of Least Privilege.

Initially, the IAM policy contains no permissions. Permissions will be added incrementally as additional AWS services are introduced in later milestones.

This approach ensures that EC2 instances receive only the permissions required by the deployed infrastructure.

## Outputs

- EC2 IAM Role Name
- EC2 IAM Role ARN
- EC2 Instance Profile Name
- EC2 Instance Profile ARN
