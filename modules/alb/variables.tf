variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for the ALB"
  type        = list(string)
}

variable "alb_ingress_cidr_blocks" {
  description = "CIDR blocks allowed to access the ALB"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "listener_port" {
  description = "Listener port for ALB"
  type        = number
  default     = 80
}

variable "listener_protocol" {
  description = "Listener protocol"
  type        = string
  default     = "HTTP"
}

variable "target_group_port" {
  description = "Port for target group"
  type        = number
  default     = 80
}

variable "target_group_protocol" {
  description = "Protocol for target group"
  type        = string
  default     = "HTTP"
}

variable "health_check_path" {
  description = "Health check path for backend service"
  type        = string
  default     = "/"
}

variable "health_check_matcher" {
  description = "Expected HTTP codes for health check"
  type        = string
  default     = "200"
}

variable "alb_security_group_id" {
  description = "Alb security group"
  type        = string
}