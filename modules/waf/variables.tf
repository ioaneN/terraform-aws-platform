variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "alb_arn" {
  description = "ARN of the ALB to protect"
  type        = string
}

variable "rate_limit" {
  description = "Requests per 5-minute period per IP before blocking"
  type        = number
  default     = 2000
}