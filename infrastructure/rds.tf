resource "aws_db_subnet_group" "gym_platform_db_subnet_group" {
  name        = "${var.r_prefix}-db-subnet-group"
  description = "Database subnet group for gym platform"
  subnet_ids = [
    aws_subnet.gym_platform_public_subnet_1a.id,
    aws_subnet.gym_platform_public_subnet_1c.id
  ]

  tags = {
    Name        = "${var.r_prefix}-db-subnet-group"
    Environment = var.environment
  }
}

resource "aws_db_instance" "gym_platform_db" {
  identifier     = "${var.r_prefix}-db"
  engine         = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"

  allocated_storage = 20
  storage_type      = "gp2"

  db_name  = var.database_name
  username = var.database_username
  password = var.database_password
  port     = 3306

  vpc_security_group_ids = [aws_security_group.gym_platform_sg_db.id]
  db_subnet_group_name   = aws_db_subnet_group.gym_platform_db_subnet_group.name

  backup_retention_period = 1
  skip_final_snapshot     = true

  tags = {
    Name        = "${var.r_prefix}-db"
    Environment = var.environment
  }
}
