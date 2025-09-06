resource "aws_security_group" "gym_platform_sg_app" {
  name        = "${var.r_prefix}-sg-app"
  description = "Security group for gym platform application"
  vpc_id      = aws_vpc.gym_platform_vpc.id

  ingress {
    description = "HTTP from ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description = "Rails server"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.r_prefix}-sg-app"
    Environment = var.environment
  }
}

# Application Load Balancer Security Group
resource "aws_security_group" "gym_platform_sg_alb" {
  name        = "${var.r_prefix}-sg-alb"
  description = "Security group for gym platform ALB"
  vpc_id      = aws_vpc.gym_platform_vpc.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.r_prefix}-sg-alb"
    Environment = var.environment
  }
}

# Database Security Group
resource "aws_security_group" "gym_platform_sg_db" {
  name        = "${var.r_prefix}-sg-db"
  description = "Security group for gym platform database"
  vpc_id      = aws_vpc.gym_platform_vpc.id

  ingress {
    description     = "MySQL from app"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.gym_platform_sg_app.id]
  }

  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.r_prefix}-sg-db"
    Environment = var.environment
  }
}
