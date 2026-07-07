# CloudFront Module

## Purpose

This module provisions a production-ready Amazon CloudFront distribution for the AWS Infrastructure project.

The module is designed to be reusable and follows AWS Well-Architected Framework recommendations.

## Resources

- CloudFront Distribution
- CloudFront Origin Access Control (OAC)

## Features

- IPv6 enabled
- HTTPS viewer redirection
- Response compression
- Origin Access Control (OAC)
- Support for multiple origins
- Configurable price class
- Resource tagging

## Origins

The module supports two origins:

1. Application Load Balancer (default origin)
2. Amazon S3 assets bucket

The CloudFront distribution will be integrated into the production environment after the Application Load Balancer has been provisioned.

## Outputs

- Distribution ID
- Distribution ARN
- Distribution Domain Name
- Hosted Zone ID
- Origin Access Control ID
