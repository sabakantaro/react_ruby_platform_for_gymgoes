resource "aws_subnet" "gym_platform_public_subnet_1a" {
  vpc_id                  = aws_vpc.gym_platform_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.r_prefix}-public-subnet-1a"
    Environment = var.environment
  }
}

resource "aws_subnet" "gym_platform_public_subnet_1c" {
  vpc_id                  = aws_vpc.gym_platform_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.r_prefix}-public-subnet-1c"
    Environment = var.environment
  }
}
