resource "aws_lb" "gym_platform_alb" {
  name               = "${var.r_prefix}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.gym_platform_sg_alb.id]

  subnets = [
    aws_subnet.gym_platform_public_subnet_1a.id,
    aws_subnet.gym_platform_public_subnet_1c.id
  ]

  enable_deletion_protection = false

  access_logs {
    bucket  = aws_s3_bucket.gym_platform_alb_logs.bucket
    enabled = true
  }

  tags = {
    Name        = "${var.r_prefix}-alb"
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "gym_platform_alb_tg" {
  name                 = "${var.r_prefix}-alb-tg"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = aws_vpc.gym_platform_vpc.id
  target_type          = "ip"
  deregistration_delay = 15

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name        = "${var.r_prefix}-alb-tg"
    Environment = var.environment
  }
}

resource "aws_lb_listener" "gym_platform_alb_listener" {
  load_balancer_arn = aws_lb.gym_platform_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.gym_platform_alb_tg.arn
  }

  tags = {
    Name        = "${var.r_prefix}-alb-listener"
    Environment = var.environment
  }
}

# Frontend target group (for React app)
resource "aws_lb_target_group" "gym_platform_frontend_tg" {
  name                 = "${var.r_prefix}-frontend-tg"
  port                 = 3000
  protocol             = "HTTP"
  vpc_id               = aws_vpc.gym_platform_vpc.id
  target_type          = "ip"
  deregistration_delay = 15

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name        = "${var.r_prefix}-frontend-tg"
    Environment = var.environment
  }
}

# API target group (for Rails backend)
resource "aws_lb_target_group" "gym_platform_api_tg" {
  name                 = "${var.r_prefix}-api-tg"
  port                 = 3001
  protocol             = "HTTP"
  vpc_id               = aws_vpc.gym_platform_vpc.id
  target_type          = "ip"
  deregistration_delay = 15

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/api/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name        = "${var.r_prefix}-api-tg"
    Environment = var.environment
  }
}

# Listener rules for routing
resource "aws_lb_listener_rule" "gym_platform_api_rule" {
  listener_arn = aws_lb_listener.gym_platform_alb_listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.gym_platform_api_tg.arn
  }

  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }

  tags = {
    Name        = "${var.r_prefix}-api-rule"
    Environment = var.environment
  }
}

resource "aws_lb_listener_rule" "gym_platform_frontend_rule" {
  listener_arn = aws_lb_listener.gym_platform_alb_listener.arn
  priority     = 200

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.gym_platform_frontend_tg.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }

  tags = {
    Name        = "${var.r_prefix}-frontend-rule"
    Environment = var.environment
  }
}
