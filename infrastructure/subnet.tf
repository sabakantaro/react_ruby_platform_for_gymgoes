resource "aws_subnet" "gym_platform_public_subnet_1a" {
  vpc_id                  = aws_vpc.gym_platform_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.r_prefix}-public-subnet-1a"
    Environment = var.environment
    Type        = "Public"
  }
}

resource "aws_subnet" "gym_platform_public_subnet_1c" {
  vpc_id                  = aws_vpc.gym_platform_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.r_prefix}-public-subnet-1c"
    Environment = var.environment
    Type        = "Public"
  }
}

resource "aws_subnet" "gym_platform_private_subnet_1a" {
  vpc_id            = aws_vpc.gym_platform_vpc.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name        = "${var.r_prefix}-private-subnet-1a"
    Environment = var.environment
    Type        = "Private"
  }
}

resource "aws_subnet" "gym_platform_private_subnet_1c" {
  vpc_id            = aws_vpc.gym_platform_vpc.id
  cidr_block        = "10.0.11.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name        = "${var.r_prefix}-private-subnet-1c"
    Environment = var.environment
    Type        = "Private"
  }
}
