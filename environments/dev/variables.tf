variable "aws_region" {
  description = "AWS region for the environment"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDRs for public subnets"
  type        = list(string)
}

variable "private_app_subnet_cidrs" {
  description = "CIDRs for private app subnets"
  type        = list(string)
}

variable "private_db_subnet_cidrs" {
  description = "CIDRs for private db subnets"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Whether to create NAT Gateway"
  type        = bool
  default     = true
}

variable "alb_ingress_cidr_blocks" {
  description = "CIDR blocks allowed to access the ALB"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "alb_listener_port" {
  description = "ALB listener port"
  type        = number
  default     = 80
}

variable "alb_listener_protocol" {
  description = "ALB listener protocol"
  type        = string
  default     = "HTTP"
}

variable "backend_target_group_port" {
  description = "Backend target group port"
  type        = number
  default     = 80
}

variable "backend_target_group_protocol" {
  description = "Backend target group protocol"
  type        = string
  default     = "HTTP"
}

variable "backend_health_check_path" {
  description = "Health check path for backend target group"
  type        = string
  default     = "/"
}

variable "backend_health_check_matcher" {
  description = "Expected HTTP codes for backend health check"
  type        = string
  default     = "200"
}

variable "container_name" {
  description = "Backend container name"
  type        = string
}

variable "container_image" {
  description = "Backend container image"
  type        = string
}

variable "container_port" {
  description = "Backend container port"
  type        = number
}

variable "desired_count" {
  description = "Desired ECS task count"
  type        = number
  default     = 1
}

variable "ecs_task_cpu" {
  description = "ECS task CPU units"
  type        = number
  default     = 256
}

variable "ecs_task_memory" {
  description = "ECS task memory in MiB"
  type        = number
  default     = 512
}


variable "db_engine_version" {
  description = "PostgreSQL engine version"
  type        = string
  default     = "16.3"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Initial DB storage in GB"
  type        = number
  default     = 20
}

variable "db_max_allocated_storage" {
  description = "Maximum DB storage in GB"
  type        = number
  default     = 100
}

variable "db_name" {
  description = "Initial database name"
  type        = string
}

variable "db_username" {
  description = "Database master username"
  type        = string
}

variable "db_password" {
  description = "Database master password"
  type        = string
  sensitive   = true
}

variable "db_port" {
  description = "Database port"
  type        = number
  default     = 5432
}

variable "db_multi_az" {
  description = "Enable Multi-AZ for DB"
  type        = bool
  default     = false
}

variable "db_deletion_protection" {
  description = "Enable deletion protection for DB"
  type        = bool
  default     = false
}

variable "db_skip_final_snapshot" {
  description = "Skip final snapshot when destroying DB"
  type        = bool
  default     = true
}

variable "db_backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
  default     = 7
}

variable "frontend_bucket_name" {
  description = "S3 bucket name for frontend static website"
  type        = string
}

variable "frontend_index_document" {
  description = "Frontend index document"
  type        = string
  default     = "index.html"
}

variable "frontend_error_document" {
  description = "Frontend error document"
  type        = string
  default     = "error.html"
}

variable "hosted_zone_name" {
  description = "Public Route53 hosted zone name"
  type        = string
}

variable "backend_domain_name" {
  description = "Custom domain for backend ALB"
  type        = string
}

variable "frontend_domain_name" {
  description = "Custom domain for S3 frontend"
  type        = string
}

variable "enable_https" {
  description = "Whether to enable HTTPS and ACM for this environment"
  type        = bool
  default     = false
}

variable "waf_rate_limit" {
  description = "Requests per 5-minute period per IP before WAF blocks"
  type        = number
  default     = 2000
}