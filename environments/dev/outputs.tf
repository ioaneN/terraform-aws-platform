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
