# Architecture Overview

This platform will deploy:
- VPC across multiple AZs
- Public and private subnets
- NAT gateways
- ECS Fargate services
- ALB ingress
- RDS PostgreSQL in private subnets
- S3 static frontend
- CloudFront CDN
- Route53 DNS
- ACM TLS certificates
- WAF protection
- Monitoring and alerting

Environments:
- dev
- stage
- prod
