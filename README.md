# Production-Grade Multi-Environment AWS Platform with Terraform

This project demonstrates a production-style AWS infrastructure platform built with Terraform.

## Features
- Multi-environment structure (dev, stage, prod)
- Reusable Terraform modules
- Remote state with S3 and DynamoDB
- VPC and networking
- ECS Fargate workloads
- Application Load Balancer
- RDS PostgreSQL
- S3 + CloudFront static frontend
- Route53 + ACM
- WAF
- Monitoring and observability
- CI/CD integration

## Structure
- `environments/` for per-environment deployments
- `modules/` for reusable infrastructure components
- `docs/` for architecture documentation

## Environments
- dev
- stage
- prod