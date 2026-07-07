# Networking Module

## Purpose

This module provisions the foundational AWS networking infrastructure for the project.

## Resources

The module provisions:

- Amazon VPC
- Internet Gateway
- Public Subnets
- Private Subnets
- Public Route Table
- Private Route Table
- Route Table Associations
- Elastic IP
- NAT Gateway

## Design

The network is deployed across two Availability Zones to provide High Availability and Fault Tolerance.

### Public Subnets

Used for:

- Application Load Balancer

### Private Subnets

Used for:

- EC2 Instances
- Auto Scaling Group

The private subnets do not have direct Internet access.

Outbound Internet connectivity is provided through a NAT Gateway located in a public subnet, allowing instances to:

- Install operating system packages.
- Receive security updates.
- Download deployment artifacts.
- Access AWS services that require Internet connectivity.

## Inputs

Refer to [variables.tf](./variables.tf).

## Outputs

Refer to [outputs.tf](./outputs.tf).
