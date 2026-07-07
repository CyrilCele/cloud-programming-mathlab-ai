# Launch Template Module

## Purpose

This module provisions a production-ready Amazon EC2 Launch Template for the web tier.

## Resources

- EC2 Launch Template

## Features

- Ubuntu Server AMI
- IMDSv2 enforced
- Private networking
- IAM Instance Profile
- Detailed monitoring enabled
- Encrypted gp3 root volume
- User Data support
- Common resource tagging

## Inputs

- Project name
- Environment
- Ubuntu AMI ID
- Instance type
- EC2 Security Group ID
- IAM Instance Profile
- User Data
- Common tags

## Outputs

- Launch Template ID
- Launch Template ARN
- Launch Template Name
- Latest Version

## Notes

The Launch Template is intentionally independent of the Auto Scaling Group. It will be integrated during Milestone 8.

Website deployment logic will also be finalized during Auto Scaling integration after deployment artifacts are retrieved from Amazon S3.
