# Auto Scaling Module

## Purpose

This module provisions a production-ready Amazon EC2 Auto Scaling Group.

## Resources

- Auto Scaling Group

## Features

- Multi-Availability Zone deployment
- Launch Template integration
- Application Load Balancer Target Group integration
- ELB health checks
- Zero-downtime updates
- Resource tagging

## Inputs

- Project name
- Environment
- Launch Template ID
- Launch Template version
- Private subnet IDs
- Target Group ARN
- Desired capacity
- Minimum size
- Maximum size
- Common tags

## Outputs

- Auto Scaling Group ID
- Auto Scaling Group Name
- Auto Scaling Group ARN

## Notes

The Auto Scaling Group launches EC2 instances using the Launch Template and automatically registers healthy instances with the Application Load Balancer Target Group.

Scaling policies and CloudWatch alarms are implemented separately to keep the module focused on Auto Scaling infrastructure.
