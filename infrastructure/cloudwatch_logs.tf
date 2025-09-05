resource "aws_cloudwatch_log_group" "gym_platform_app_log_group" {
  name              = "/ecs/gym-platform-app"
  retention_in_days = 7

  tags = {
    Name        = "${var.r_prefix}-app-log-group"
    Environment = var.environment
  }
}

resource "aws_cloudwatch_log_group" "gym_platform_frontend_log_group" {
  name              = "/ecs/gym-platform-frontend"
  retention_in_days = 7

  tags = {
    Name        = "${var.r_prefix}-frontend-log-group"
    Environment = var.environment
  }
}

resource "aws_cloudwatch_log_group" "gym_platform_nginx_log_group" {
  name              = "/ecs/gym-platform-nginx"
  retention_in_days = 7

  tags = {
    Name        = "${var.r_prefix}-nginx-log-group"
    Environment = var.environment
  }
}
