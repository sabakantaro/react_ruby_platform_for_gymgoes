resource "aws_cloudwatch_log_group" "gym_platform_backend" {
  name              = "/ecs/${var.r_prefix}-backend"
  retention_in_days = 7

  tags = {
    Name        = "${var.r_prefix}-backend-logs"
    Environment = var.environment
  }
}

resource "aws_cloudwatch_log_group" "gym_platform_frontend" {
  name              = "/ecs/${var.r_prefix}-frontend"
  retention_in_days = 7

  tags = {
    Name        = "${var.r_prefix}-frontend-logs"
    Environment = var.environment
  }
}