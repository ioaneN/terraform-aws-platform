aws_region   = "us-east-1"
project_name = "terraform-aws-platform"
environment  = "dev"
vpc_cidr     = "10.10.0.0/16"

azs = [
  "us-east-1a",
  "us-east-1b"
]

public_subnet_cidrs = [
  "10.10.1.0/24",
  "10.10.2.0/24"
]

private_app_subnet_cidrs = [
  "10.10.11.0/24",
  "10.10.12.0/24"
]

private_db_subnet_cidrs = [
  "10.10.21.0/24",
  "10.10.22.0/24"
]

enable_nat_gateway = true


alb_ingress_cidr_blocks = ["0.0.0.0/0"]

alb_listener_port     = 80
alb_listener_protocol = "HTTP"

backend_target_group_port     = 80
backend_target_group_protocol = "HTTP"
backend_health_check_path     = "/"
backend_health_check_matcher  = "200"

container_name  = "backend"
container_image = "public.ecr.aws/docker/library/nginx:latest"
container_port  = 80

desired_count   = 1
ecs_task_cpu    = 256
ecs_task_memory = 512