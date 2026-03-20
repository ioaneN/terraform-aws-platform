locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

resource "aws_ecs_cluster" "this" {
  name = "${local.name_prefix}-ecs-cluster"

  tags = {
    Name        = "${local.name_prefix}-ecs-cluster"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/ecs/${local.name_prefix}-${var.container_name}"
  retention_in_days = 7

  tags = {
    Name        = "${local.name_prefix}-ecs-logs"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_ecs_task_definition" "this" {
  family                   = "${local.name_prefix}-${var.container_name}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = tostring(var.cpu)
  memory                   = tostring(var.memory)
  execution_role_arn       = var.ecs_task_execution_role_arn
  task_role_arn            = var.ecs_task_role_arn

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.container_image
      essential = true

      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.this.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }

      healthCheck = {
        command     = ["CMD-SHELL", "curl -f http://localhost:${var.container_port}${var.health_check_path} || exit 1"]
        interval    = 30
        timeout     = 5
        retries     = 3
        startPeriod = 15
      }
    }
  ])

  tags = {
    Name        = "${local.name_prefix}-task-definition"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_ecs_service" "this" {
  name            = "${local.name_prefix}-${var.container_name}-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [var.ecs_service_sg_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  depends_on = [
    aws_ecs_task_definition.this
  ]

  tags = {
    Name        = "${local.name_prefix}-${var.container_name}-service"
    Environment = var.environment
    Project     = var.project_name
  }
}