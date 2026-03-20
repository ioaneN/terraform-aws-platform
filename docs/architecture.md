# Architecture Overview

This project is building a production-style multi-environment AWS platform with reusable Terraform modules.

## Target Architecture

The platform is designed to include:
- VPC across multiple Availability Zones
- Public and private subnets
- NAT Gateway for outbound private subnet access
- ECS Fargate services
- Application Load Balancer (ALB)
- RDS PostgreSQL in private database subnets
- S3 static frontend hosting
- CloudFront CDN
- Route53 DNS
- ACM TLS certificates
- WAF protection
- Monitoring and alerting

## Currently Implemented

### Dev Environment
The following components are currently implemented in `dev`:
- Custom VPC
- 2 public subnets across 2 Availability Zones
- 2 private application subnets
- 2 private database subnets
- Internet Gateway
- 1 NAT Gateway
- Public route table
- Private route table
- Subnet route table associations

## Environment Strategy

The infrastructure is being built and validated in this order:
- `dev` first
- `stage` later
- `prod` last

This allows the reusable Terraform modules to be tested in `dev` before being promoted to higher environments.

## Planned Work

Upcoming platform layers:
- Security groups and IAM basics
- ALB and target groups
- ECS Fargate backend
- RDS PostgreSQL
- S3 frontend and CloudFront
- Route53 and ACM
- WAF and security hardening
- Monitoring, logging, and alerts
- CI/CD pipeline
- Final documentation and production polish