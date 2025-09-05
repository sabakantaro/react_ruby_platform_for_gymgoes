resource "aws_internet_gateway" "gym_platform_igw" {
  vpc_id = aws_vpc.gym_platform_vpc.id

  tags = {
    Name        = "${var.r_prefix}-igw"
    Environment = var.environment
  }
}
