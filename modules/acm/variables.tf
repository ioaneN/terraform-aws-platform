variable "domain_name" {
  description = "Primary domain name for the certificate"
  type        = string
}

variable "subject_alternative_names" {
  description = "Additional SANs for the certificate"
  type        = list(string)
  default     = []
}

variable "hosted_zone_name" {
  description = "Route53 hosted zone name"
  type        = string
}