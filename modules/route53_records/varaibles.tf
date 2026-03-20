variable "hosted_zone_name" {
  description = "Route53 hosted zone name"
  type        = string
}

variable "backend_record_name" {
  description = "Backend DNS record"
  type        = string
}

variable "alb_dns_name" {
  description = "ALB DNS name"
  type        = string
}

variable "alb_zone_id" {
  description = "ALB hosted zone ID"
  type        = string
}

variable "frontend_record_name" {
  description = "Frontend DNS record"
  type        = string
}

variable "frontend_website_domain" {
  description = "S3 website domain"
  type        = string
}