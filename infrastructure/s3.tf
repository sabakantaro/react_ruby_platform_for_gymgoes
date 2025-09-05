# S3 bucket for ALB logs
resource "aws_s3_bucket" "gym_platform_alb_logs" {
  bucket = "${var.r_prefix}-alb-logs-${formatdate("YYYYMMDD", timestamp())}"

  tags = {
    Name        = "${var.r_prefix}-alb-logs"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "gym_platform_alb_logs_versioning" {
  bucket = aws_s3_bucket.gym_platform_alb_logs.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "gym_platform_alb_logs_lifecycle" {
  bucket = aws_s3_bucket.gym_platform_alb_logs.id

  rule {
    id     = "log_retention"
    status = "Enabled"

    expiration {
      days = 30
    }

    noncurrent_version_expiration {
      noncurrent_days = 7
    }
  }
}

# S3 bucket for application assets (optional)
resource "aws_s3_bucket" "gym_platform_assets" {
  bucket = "${var.r_prefix}-assets-${formatdate("YYYYMMDD", timestamp())}"

  tags = {
    Name        = "${var.r_prefix}-assets"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "gym_platform_assets_versioning" {
  bucket = aws_s3_bucket.gym_platform_assets.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "gym_platform_assets_pab" {
  bucket = aws_s3_bucket.gym_platform_assets.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Bucket policy for public read access to assets
resource "aws_s3_bucket_policy" "gym_platform_assets_policy" {
  bucket = aws_s3_bucket.gym_platform_assets.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.gym_platform_assets.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.gym_platform_assets_pab]
}
