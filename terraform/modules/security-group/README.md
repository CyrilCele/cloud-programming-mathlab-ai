# Security Groups Module

## Purpose

This module provisions the security groups used by the AWS infrastructure.

## Resources

- Application Load Balancer Security Group
- EC2 Instance Security Group

## Traffic Flow

Internet

↓

Application Load Balancer

↓

EC2 Instances

The Application Load Balancer accepts HTTP and HTTPS traffic from the Internet.

EC2 instances accept HTTP traffic only from the Application Load Balancer security group.

No inbound SSH access is permitted.

## Outputs

- ALB Security Group ID
- EC2 Security Group ID
