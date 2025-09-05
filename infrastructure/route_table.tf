resource "aws_route_table" "gym_platform_public_rt" {
  vpc_id = aws_vpc.gym_platform_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gym_platform_igw.id
  }

  tags = {
    Name        = "${var.r_prefix}-public-rt"
    Environment = var.environment
    Type        = "Public"
  }
}

resource "aws_route_table_association" "gym_platform_public_subnet_1a_rt_assoc" {
  subnet_id      = aws_subnet.gym_platform_public_subnet_1a.id
  route_table_id = aws_route_table.gym_platform_public_rt.id
}

resource "aws_route_table_association" "gym_platform_public_subnet_1c_rt_assoc" {
  subnet_id      = aws_subnet.gym_platform_public_subnet_1c.id
  route_table_id = aws_route_table.gym_platform_public_rt.id
}

# Private route table (for future NAT Gateway usage)
resource "aws_route_table" "gym_platform_private_rt" {
  vpc_id = aws_vpc.gym_platform_vpc.id

  tags = {
    Name        = "${var.r_prefix}-private-rt"
    Environment = var.environment
    Type        = "Private"
  }
}

resource "aws_route_table_association" "gym_platform_private_subnet_1a_rt_assoc" {
  subnet_id      = aws_subnet.gym_platform_private_subnet_1a.id
  route_table_id = aws_route_table.gym_platform_private_rt.id
}

resource "aws_route_table_association" "gym_platform_private_subnet_1c_rt_assoc" {
  subnet_id      = aws_subnet.gym_platform_private_subnet_1c.id
  route_table_id = aws_route_table.gym_platform_private_rt.id
}
