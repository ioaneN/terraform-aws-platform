# Production-Grade Multi-Environment AWS Platform with Terraform

This project demonstrates a production-style AWS infrastructure platform built with Terraform, using a reusable multi-environment structure for AWS deployments.

## Project Goal

Build a portfolio-grade AWS platform that reflects real-world infrastructure design and Terraform best practices across `dev`, `stage`, and `prod`.


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

## Phase 1 — Foundation
- Repository structure initialized
- Environment folders created
- Terraform backend configured with S3
- State locking configured with DynamoDB
- Provider/version files prepared

## Phase 2 — VPC + Networking
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
```

## Phase 3: Security groups + IAM basics

This phase introduces the base security layer for the platform.

### Implemented
- Reusable `security_groups` module
- Reusable `iam_basic` module
- ALB security group allowing inbound HTTP/HTTPS from the internet
- ECS service security group allowing inbound application traffic only from the ALB
- RDS security group allowing PostgreSQL access only from the ECS service
- ECS task execution role
- ECS task role
- Attachment of the AWS managed `AmazonECSTaskExecutionRolePolicy`

### Security model
Traffic is restricted through security groups using this flow:

`Internet -> ALB -> ECS -> RDS`

This means:
- the load balancer is the only public entry point
- the application is reachable only from the ALB
- the database is reachable only from the application layer

### Notes
- IAM in this phase is intentionally minimal
- more detailed permissions for Secrets Manager, S3, CloudWatch, and app-specific access will be added in later phases
- implementation is currently applied in the `dev` environment firstcd


## Phase 4: ALB + Target Groups

This phase adds the load balancing layer for the `dev` environment.

Implemented:
- Application Load Balancer (ALB) across public subnets
- backend target group for application traffic
- HTTP listener on port 80
- integration with the existing ALB security group created in the security phase
- outputs for ALB DNS name and backend target group ARN

This prepares the platform for the next phase, where the ECS Fargate service will be attached to the target group and will receive traffic through the ALB.


## Phase 5 - ECS Fargate Backend

Implemented the ECS Fargate backend for the dev environment.

### Added
- ECS cluster
- ECS task definition
- ECS service
- CloudWatch log group
- Fargate tasks deployed in private app subnets
- Integration between ECS service and existing ALB target group
- Reuse of IAM roles from the IAM module
- Reuse of ECS service security group from the security module

### Result
The backend application now runs on ECS Fargate in private subnets and is exposed through the Application Load Balancer.

## Phase 6: RDS PostgreSQL

This phase adds the database layer for the platform.

### Implemented
- Created a reusable `rds` Terraform module
- Provisioned a PostgreSQL RDS instance in the `dev` environment
- Created a DB subnet group using private database subnets
- Attached the RDS instance to the database security group
- Restricted the database to private networking only
- Added outputs for database endpoint, port, name, and subnet group

### Architecture
The database is deployed in private DB subnets and is not publicly accessible.

Traffic flow:

`Internet -> ALB -> ECS -> RDS`

This means:
- users access the application through the ALB
- the ECS backend communicates with PostgreSQL privately
- the database is protected by subnet isolation and security groups

### Notes
- Phase 6 uses a PostgreSQL RDS instance for the backend database layer
- The database is intended for application access only, not public access
- `dev` uses cost-conscious settings for now
- Secret handling can be improved later with AWS Secrets Manager

## Phase 7 - S3 Frontend

Implemented a static frontend hosted on Amazon S3.

### Added
- Reusable `s3_frontend` Terraform module
- S3 bucket for frontend assets
- Static website hosting configuration
- Public read bucket policy for website content
- Environment-level outputs for website endpoint

### Result
The frontend can now be served directly from the S3 website endpoint in the dev environment.