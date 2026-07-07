# Application Load Balancer Module

## Purpose

This module provisions a production-ready internet-facing Application Load Balancer (ALB).

## Resources

- Application Load Balancer
- Target Group
- HTTP Listener

## Features

- Internet-facing
- Multi-AZ deployment
- HTTP listener
- Target group with health checks
- Dedicated security group
- Resource tagging

## Inputs

- Project name
- Environment
- VPC ID
- Public subnet IDs
- ALB Security Group ID
- Common tags

## Outputs

- ALB ID
- ALB ARN
- ALB DNS Name
- Hosted Zone ID
- Target Group ARN

## Notes

The Application Load Balancer is deployed across the public subnets and forwards incoming HTTP requests to the Target Group.

The Auto Scaling Group will register EC2 instances with the Target Group during Milestone 8.

CloudFront is deployed in front of the Application Load Balancer and acts as the public entry point for client requests.

HTTPS support will be enabled after AWS Certificate Manager (ACM) certificates and Amazon Route 53 DNS records are provisioned.
