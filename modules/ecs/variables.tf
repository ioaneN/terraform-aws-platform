variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for ECS tasks"
  type        = list(string)
}

variable "ecs_service_sg_id" {
  description = "Security group ID for ECS service"
  type        = string
}

variable "target_group_arn" {
  description = "ALB target group ARN for backend service"
  type        = string
}

variable "ecs_task_execution_role_arn" {
  description = "ECS task execution role ARN"
  type        = string
}

variable "ecs_task_role_arn" {
  description = "ECS task role ARN"
  type        = string
}

variable "container_name" {
  description = "Container name"
  type        = string
}

variable "container_image" {
  description = "Container image"
  type        = string
}

variable "container_port" {
  description = "Application container port"
  type        = number
}

variable "desired_count" {
  description = "Desired number of ECS tasks"
  type        = number
  default     = 1
}

variable "cpu" {
  description = "Task CPU"
  type        = number
  default     = 256
}

variable "memory" {
  description = "Task memory"
  type        = number
  default     = 512
}

variable "health_check_path" {
  description = "Health endpoint path"
  type        = string
  default     = "/"
}