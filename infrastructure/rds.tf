resource "aws_db_subnet_group" "gym_platform_db_subnet_group" {
  name        = "${var.r_prefix}-db-subnet-group-${formatdate("YYYYMMDD", timestamp())}"
  description = "Database subnet group for gym platform"
  subnet_ids = [
    aws_subnet.gym_platform_private_subnet_1a.id,
    aws_subnet.gym_platform_private_subnet_1c.id
  ]

  tags = {
    Name        = "${var.r_prefix}-db-subnet-group"
    Environment = var.environment
  }
}

resource "aws_db_instance" "gym_platform_db" {
  identifier     = "${var.r_prefix}-db"
  engine         = "postgres"
  engine_version = "15.13"
  instance_class = "db.t3.micro"

  allocated_storage     = 20
  max_allocated_storage = 100
  storage_type          = "gp2"
  storage_encrypted     = true

  db_name  = var.database_name
  username = var.database_username
  password = var.database_password
  port     = 5432

  vpc_security_group_ids = [aws_security_group.gym_platform_sg_db.id]
  db_subnet_group_name   = aws_db_subnet_group.gym_platform_db_subnet_group.name

  backup_retention_period = 7
  backup_window          = "03:00-04:00"
  maintenance_window     = "sun:04:00-sun:05:00"

  skip_final_snapshot       = true
  final_snapshot_identifier = "${var.r_prefix}-db-final-snapshot"

  # Enable automated backups
  copy_tags_to_snapshot = true

  # Performance Insights (optional, might incur additional charges)
  performance_insights_enabled = false

  tags = {
    Name        = "${var.r_prefix}-db"
    Environment = var.environment
  }
}
