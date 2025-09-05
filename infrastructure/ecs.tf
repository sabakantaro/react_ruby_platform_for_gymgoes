resource "aws_ecs_cluster" "gym_platform_cluster" {
  name = "${var.r_prefix}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name        = "${var.r_prefix}-cluster"
    Environment = var.environment
  }
}

# Task definition for the backend (Rails API)
resource "aws_ecs_task_definition" "gym_platform_backend" {
  family                   = "${var.r_prefix}-backend"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = "arn:aws:iam::${var.aws_account_id}:role/ecsTaskExecutionRole"
  task_role_arn           = "arn:aws:iam::${var.aws_account_id}:role/ecsTaskExecutionRole"

  container_definitions = jsonencode([
    {
      name  = "backend"
      image = "${aws_ecr_repository.gym_platform_app.repository_url}:latest"
      
      portMappings = [
        {
          containerPort = 3001
          protocol      = "tcp"
        }
      ]
      
      environment = [
        {
          name  = "RAILS_ENV"
          value = "production"
        },
        {
          name  = "DATABASE_URL"
          value = "postgresql://${var.database_username}:${var.database_password}@${aws_db_instance.gym_platform_db.endpoint}:5432/${var.database_name}"
        }
      ]
      
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.gym_platform_app_log_group.name
          "awslogs-region"        = "ap-northeast-1"
          "awslogs-stream-prefix" = "ecs"
        }
      }
      
      essential = true
    }
  ])

  tags = {
    Name        = "${var.r_prefix}-backend-task"
    Environment = var.environment
  }
}

# Task definition for the frontend (React)
resource "aws_ecs_task_definition" "gym_platform_frontend" {
  family                   = "${var.r_prefix}-frontend"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = "arn:aws:iam::${var.aws_account_id}:role/ecsTaskExecutionRole"
  task_role_arn           = "arn:aws:iam::${var.aws_account_id}:role/ecsTaskExecutionRole"

  container_definitions = jsonencode([
    {
      name  = "frontend"
      image = "${aws_ecr_repository.gym_platform_frontend.repository_url}:latest"
      
      portMappings = [
        {
          containerPort = 3000
          protocol      = "tcp"
        }
      ]
      
      environment = [
        {
          name  = "NODE_ENV"
          value = "production"
        },
        {
          name  = "REACT_APP_API_URL"
          value = "http://${aws_lb.gym_platform_alb.dns_name}/api"
        }
      ]
      
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.gym_platform_frontend_log_group.name
          "awslogs-region"        = "ap-northeast-1"
          "awslogs-stream-prefix" = "ecs"
        }
      }
      
      essential = true
    }
  ])

  tags = {
    Name        = "${var.r_prefix}-frontend-task"
    Environment = var.environment
  }
}

# ECS Service for backend
resource "aws_ecs_service" "gym_platform_backend_service" {
  name            = "${var.r_prefix}-backend-service"
  cluster         = aws_ecs_cluster.gym_platform_cluster.id
  task_definition = aws_ecs_task_definition.gym_platform_backend.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  deployment_configuration {
    maximum_percent         = 200
    minimum_healthy_percent = 100
  }

  network_configuration {
    subnets = [
      aws_subnet.gym_platform_public_subnet_1a.id,
      aws_subnet.gym_platform_public_subnet_1c.id
    ]
    security_groups  = [aws_security_group.gym_platform_sg_app.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.gym_platform_api_tg.arn
    container_name   = "backend"
    container_port   = 3001
  }

  depends_on = [aws_lb_listener.gym_platform_alb_listener]

  lifecycle {
    ignore_changes = [desired_count, task_definition]
  }

  tags = {
    Name        = "${var.r_prefix}-backend-service"
    Environment = var.environment
  }
}

# ECS Service for frontend
resource "aws_ecs_service" "gym_platform_frontend_service" {
  name            = "${var.r_prefix}-frontend-service"
  cluster         = aws_ecs_cluster.gym_platform_cluster.id
  task_definition = aws_ecs_task_definition.gym_platform_frontend.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  deployment_configuration {
    maximum_percent         = 200
    minimum_healthy_percent = 100
  }

  network_configuration {
    subnets = [
      aws_subnet.gym_platform_public_subnet_1a.id,
      aws_subnet.gym_platform_public_subnet_1c.id
    ]
    security_groups  = [aws_security_group.gym_platform_sg_app.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.gym_platform_frontend_tg.arn
    container_name   = "frontend"
    container_port   = 3000
  }

  depends_on = [aws_lb_listener.gym_platform_alb_listener]

  lifecycle {
    ignore_changes = [desired_count, task_definition]
  }

  tags = {
    Name        = "${var.r_prefix}-frontend-service"
    Environment = var.environment
  }
}
