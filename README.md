# Production-Grade Multi-Environment AWS Platform with Terraform

This project demonstrates a production-style AWS infrastructure platform built with Terraform, using a reusable multi-environment structure for AWS deployments.

## Project Goal

Build a portfolio-grade AWS platform that reflects real-world infrastructure design and Terraform best practices across `dev`, `stage`, and `prod`.

## Current Progress

### Completed
- Phase 1: Foundation / repo structure / remote state
- Phase 2: VPC + networking

### In Progress
- Phase 3: Security groups + IAM basics

### Planned
- ALB + target groups
- ECS Fargate backend
- RDS PostgreSQL
- S3 frontend + CloudFront
- Route53 + ACM
- WAF + security hardening
- Monitoring / logging / alerts
- CI/CD pipeline
- Docs / polish / production readiness

## Features

- Multi-environment structure (`dev`, `stage`, `prod`)
- Reusable Terraform modules
- Remote state with S3 and DynamoDB
- Custom VPC and networking foundation
- Public and private subnet design
- Internet Gateway and NAT Gateway routing
- ECS Fargate workloads
- Application Load Balancer
- RDS PostgreSQL
- S3 + CloudFront static frontend
- Route53 + ACM
- WAF
- Monitoring and observability
- CI/CD integration

## Implemented So Far

### Phase 1 — Foundation
- Repository structure initialized
- Environment folders created
- Terraform backend configured with S3
- State locking configured with DynamoDB
- Provider/version files prepared

### Phase 2 — VPC + Networking
Implemented for the `dev` environment:
- Custom VPC
- 2 public subnets across 2 Availability Zones
- 2 private application subnets
- 2 private database subnets
- Internet Gateway
- NAT Gateway
- Public and private route tables
- Subnet associations
- Terraform outputs for core network resources

## Repository Structure

```text
terraform-aws-platform/
├── docs/
├── environments/
│   ├── dev/
│   ├── stage/
│   └── prod/
├── modules/
├── scripts/
└── README.md