variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "alarm_email_endpoints" {
  description = "Email endpoints subscribed to SNS alerts"
  type        = list(string)
  default     = []
}

variable "alb_arn_suffix" {
  type = string
}

variable "target_group_arn_suffix" {
  type = string
}

variable "ecs_cluster_name" {
  type = string
}

variable "ecs_service_name" {
  type = string
}

variable "rds_instance_id" {
  type = string
}

variable "alarm_evaluation_periods" {
  type    = number
  default = 2
}

variable "alarm_period_seconds" {
  type    = number
  default = 60
}