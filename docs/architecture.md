
---

## `docs/architecture.md`


# Architecture Overview

This project builds a production-style multi-environment AWS platform with reusable Terraform modules.

It is organized so infrastructure can be implemented and validated in `dev` first, then promoted to `stage` and `prod`.

## High-Level Architecture

The platform currently consists of these core layers:

- Terraform remote state with S3 and DynamoDB
- Custom VPC across multiple Availability Zones
- Public and private subnet separation
- Application Load Balancer for ingress
- ECS Fargate for backend compute
- RDS PostgreSQL for the database layer
- S3 static website hosting for the frontend
- Route53 for DNS
- ACM for backend TLS certificate management
- AWS WAF for ALB protection
- CloudWatch logging for ECS workloads

## Environment Model

The repository is structured into separate environments:

- `dev`
- `stage`
- `prod`

The expected workflow is:

1. build and validate in `dev`
2. promote stable module patterns to `stage`
3. apply production-ready values in `prod`

## Network Design

### VPC Layout
The platform uses a custom VPC with subnet separation by responsibility:

- 2 public subnets
- 2 private application subnets
- 2 private database subnets

### Routing
- Public subnets route to the Internet Gateway
- Private subnets use a NAT Gateway for outbound internet access where needed
- Database subnets remain private and are intended only for internal service communication

### Benefits
This design provides:
- public ingress only where necessary
- private runtime placement for application services
- private database placement
- cleaner segmentation between web, app, and data tiers

## Traffic Flow

Primary traffic flow:

`Internet -> ALB -> ECS -> RDS`

This means:
- users reach the backend only through the ALB
- ECS tasks are not directly exposed to the public internet
- the database is reachable only from the application layer

For the static frontend:

`User -> Route53 -> S3 website endpoint`

The frontend is currently hosted directly from the S3 static website endpoint.

## Security Model

### Security Groups
The platform uses separate security groups for:
- ALB
- ECS service
- RDS

Rules are designed so that:
- ALB accepts public web traffic
- ECS accepts application traffic only from the ALB
- RDS accepts PostgreSQL traffic only from ECS

### IAM
The base IAM layer includes:
- ECS task execution role
- ECS task role

This establishes the minimum IAM foundation for ECS workloads and future service integrations.

### WAF
AWS WAF is attached to the ALB and includes:
- AWS Managed Common Rule Set
- AWS Managed Known Bad Inputs Rule Set
- AWS Managed Amazon IP Reputation List
- rate-based blocking rule

This provides baseline Layer 7 protection for the backend entrypoint.

## Compute Layer

The backend runs on Amazon ECS Fargate.

Implemented components:
- ECS cluster
- ECS task definition
- ECS service
- CloudWatch log group for container logs

Design characteristics:
- tasks run in private application subnets
- tasks do not receive public IPs
- the ECS service is registered behind the ALB target group
- backend health checks are performed through the ALB target group and container health checks

## Database Layer

The database layer uses Amazon RDS for PostgreSQL.

Implemented components:
- reusable RDS module
- DB subnet group in private database subnets
- private RDS placement
- security-group-based database access control

Design intent:
- application services connect privately to PostgreSQL
- database access is restricted to internal application traffic
- the database is not publicly accessible

## Frontend Layer

The frontend layer uses Amazon S3 static website hosting.

Implemented components:
- reusable S3 frontend module
- bucket for frontend assets
- website configuration
- website endpoint output
- Route53 record for frontend domain

Current constraint:
- the frontend is served from the S3 website endpoint
- this means frontend HTTPS is not provided in the current design
- full HTTPS for the frontend would require CloudFront in front of S3

## DNS and Certificates

### Route53
Route53 is used for:
- backend DNS record pointing to the ALB
- frontend DNS record pointing to the S3 website endpoint

### ACM
ACM is used for backend certificate management through DNS validation.

Design intent:
- backend domain uses ALB + ACM for HTTPS
- frontend remains separate because the current frontend hosting path is direct S3 website hosting

## Observability

### Logging
Implemented:
- ECS container logs are sent to CloudWatch Logs

### Metrics
Implemented:
- WAF visibility metrics are enabled

### Alerts
A reusable monitoring module exists for:
- SNS alert topic
- ALB alarms
- ECS alarms
- RDS alarms

At the time of this documentation update, the broader monitoring module is better treated as prepared infrastructure logic rather than fully documented as active in the verified `dev` root module wiring.

## Current Dev Environment State

The verified `dev` environment currently wires these modules in the root stack:

- `vpc`
- `security_groups`
- `iam_basic`
- `alb`
- `ecs`
- `rds`
- `s3_frontend`
- `acm`
- `route53_records`
- `waf`

This means the dev environment already represents a complete multi-tier AWS platform with networking, compute, database, frontend hosting, DNS, and edge protection.

## What Was Skipped

Phase 11 CI/CD pipeline was intentionally skipped in this version of the project.

That means this architecture document does not describe:
- GitHub Actions workflows
- automated Terraform plan/apply
- OIDC-based deployment authentication
- environment approval gates

## Production Readiness Notes

The platform is portfolio-ready and production-style, but there are still clear next-step improvements for a real production rollout:

- move secrets out of plaintext tfvars into Secrets Manager or SSM Parameter Store
- add CloudFront for frontend HTTPS and caching
- wire full monitoring and alerting in every environment
- add ECS autoscaling
- add CI/CD pipeline automation
- refine backup and recovery strategy
- promote validated modules to `stage` and `prod`

## Summary

This project demonstrates a realistic Terraform AWS platform using:

- reusable modules
- environment separation
- private application and database layers
- ALB-based ingress
- ECS Fargate backend deployment
- managed PostgreSQL
- static S3 frontend hosting
- Route53 and ACM integration
- AWS WAF protection
- CloudWatch-based logging foundation

It is a strong portfolio project because it reflects how a real platform is layered, secured, and organized for growth across multiple environments.