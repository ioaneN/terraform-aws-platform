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