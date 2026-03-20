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

  project_name = var.project_name
  environment  = var.environment

  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  alb_security_group_id = module.security_groups.alb_sg_id

  alb_ingress_cidr_blocks = var.alb_ingress_cidr_blocks
  listener_port           = var.alb_listener_port
  listener_protocol       = var.alb_listener_protocol

  target_group_port     = var.backend_target_group_port
  target_group_protocol = var.backend_target_group_protocol
  health_check_path     = var.backend_health_check_path
  health_check_matcher  = var.backend_health_check_matcher
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