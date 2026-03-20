output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_app_subnet_ids" {
  value = module.vpc.private_app_subnet_ids
}

output "private_db_subnet_ids" {
  value = module.vpc.private_db_subnet_ids
}

output "internet_gateway_id" {
  value = module.vpc.internet_gateway_id
}

output "nat_gateway_id" {
  value = module.vpc.nat_gateway_id
}

output "alb_sg_id" {
  value = module.security_groups.alb_sg_id
}

output "ecs_service_sg_id" {
  value = module.security_groups.ecs_service_sg_id
}

output "rds_sg_id" {
  value = module.security_groups.rds_sg_id
}

output "ecs_task_execution_role_arn" {
  value = module.iam_basic.ecs_task_execution_role_arn
}

output "ecs_task_role_arn" {
  value = module.iam_basic.ecs_task_role_arn
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}


output "backend_target_group_arn" {
  value = module.alb.backend_target_group_arn
}


output "db_instance_id" {
  value = module.rds.db_instance_id
}

output "db_endpoint" {
  value = module.rds.db_endpoint
}

output "db_port" {
  value = module.rds.db_port
}

output "db_name" {
  value = module.rds.db_name
}

output "db_subnet_group_name" {
  value = module.rds.db_subnet_group_name
}

output "frontend_bucket_name" {
  description = "Frontend S3 bucket name"
  value       = module.s3_frontend.bucket_name
}

output "frontend_website_endpoint" {
  description = "Frontend S3 website endpoint"
  value       = module.s3_frontend.website_endpoint
}

output "frontend_website_domain" {
  description = "Frontend S3 website domain"
  value       = module.s3_frontend.website_domain
}

output "backend_url" {
  value = "https://${var.backend_domain_name}"
}

output "frontend_url" {
  value = "http://${var.frontend_domain_name}"
}

output "acm_certificate_arn" {
  value = module.acm.certificate_arn
}