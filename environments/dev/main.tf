provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = "Ioane"
    }
  }
}

module "security_groups" {
  source = "../../modules/security_groups"

  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id
  app_port     = 3000
}

module "iam_basic" {
  source = "../../modules/iam_basic"

  project_name = var.project_name
  environment  = var.environment
}

module "vpc" {
  source = "../../modules/vpc"

  project_name             = var.project_name
  environment              = var.environment
  vpc_cidr                 = var.vpc_cidr
  azs                      = var.azs
  public_subnet_cidrs      = var.public_subnet_cidrs
  private_app_subnet_cidrs = var.private_app_subnet_cidrs
  private_db_subnet_cidrs  = var.private_db_subnet_cidrs
  enable_nat_gateway       = var.enable_nat_gateway
}

module "alb" {
  source = "../../modules/alb"

  project_name            = var.project_name
  environment             = var.environment
  vpc_id                  = module.vpc.vpc_id
  public_subnet_ids       = module.vpc.public_subnet_ids
  alb_security_group_id   = module.security_groups.alb_sg_id
  alb_ingress_cidr_blocks = var.alb_ingress_cidr_blocks
  listener_port           = var.alb_listener_port
  listener_protocol       = var.alb_listener_protocol
  target_group_port       = var.backend_target_group_port
  target_group_protocol   = var.backend_target_group_protocol
  health_check_path       = var.backend_health_check_path
  health_check_matcher    = var.backend_health_check_matcher

  enable_https        = var.enable_https
  https_listener_port = 443
  certificate_arn     = var.enable_https ? module.acm[0].certificate_arn : null
}


module "ecs" {
  source = "../../modules/ecs"

  project_name                = var.project_name
  environment                 = var.environment
  aws_region                  = var.aws_region
  private_subnet_ids          = module.vpc.private_app_subnet_ids
  ecs_service_sg_id           = module.security_groups.ecs_service_sg_id
  target_group_arn            = module.alb.backend_target_group_arn
  ecs_task_execution_role_arn = module.iam_basic.ecs_task_execution_role_arn
  ecs_task_role_arn           = module.iam_basic.ecs_task_role_arn

  container_name    = var.container_name
  container_image   = var.container_image
  container_port    = var.container_port
  desired_count     = var.desired_count
  cpu               = var.ecs_task_cpu
  memory            = var.ecs_task_memory
  health_check_path = var.backend_health_check_path
}

module "rds" {
  source = "../../modules/rds"

  project_name = var.project_name
  environment  = var.environment

  private_db_subnet_ids = module.vpc.private_db_subnet_ids
  rds_security_group_id = module.security_groups.rds_sg_id

  engine_version          = var.db_engine_version
  instance_class          = var.db_instance_class
  allocated_storage       = var.db_allocated_storage
  max_allocated_storage   = var.db_max_allocated_storage
  db_name                 = var.db_name
  db_username             = var.db_username
  db_password             = var.db_password
  db_port                 = var.db_port
  multi_az                = var.db_multi_az
  deletion_protection     = var.db_deletion_protection
  skip_final_snapshot     = var.db_skip_final_snapshot
  backup_retention_period = var.db_backup_retention_period
}

module "s3_frontend" {
  source = "../../modules/s3_frontend"

  project_name   = var.project_name
  environment    = var.environment
  bucket_name    = var.frontend_bucket_name
  index_document = var.frontend_index_document
  error_document = var.frontend_error_document
}

module "acm" {
  count  = var.enable_https ? 1 : 0
  source = "../../modules/acm"

  domain_name               = var.backend_domain_name
  hosted_zone_name          = var.hosted_zone_name
  subject_alternative_names = []
}

module "route53_records" {
  source = "../../modules/route53_records"

  hosted_zone_name        = var.hosted_zone_name
  backend_record_name     = var.backend_domain_name
  alb_dns_name            = module.alb.alb_dns_name
  alb_zone_id             = module.alb.alb_zone_id
  frontend_record_name    = var.frontend_domain_name
  frontend_website_domain = module.s3_frontend.website_domain
}

module "waf" {
  source = "../../modules/waf"

  project_name = var.project_name
  environment  = var.environment
  alb_arn      = module.alb.alb_arn
  rate_limit   = var.waf_rate_limit
}

module "monitoring" {
  source = "../../modules/monitoring"

  project_name = var.project_name
  environment  = var.environment

  alarm_email_endpoints   = var.alarm_email_endpoints
  alb_arn_suffix          = module.alb.alb_arn_suffix
  target_group_arn_suffix = module.alb.backend_target_group_arn_suffix
  ecs_cluster_name        = module.ecs.ecs_cluster_name
  ecs_service_name        = module.ecs.ecs_service_name
  rds_instance_id         = module.rds.db_instance_id
}