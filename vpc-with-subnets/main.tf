# VPC
resource "aws_vpc" "this" {
  cidr_block = var.cidr_block

  tags = {
    Name = format("${var.name_prefix}-vpc")
  }
}

# Public Subnets
resource "aws_subnet" "public" {
  for_each = {
    for i, s in var.public_subnets :
    s.az => s
  }

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = true
  availability_zone       = each.value.az

  tags = {
    Name = format("${var.name_prefix}-public-subnet-${each.value.az}")
  }
}

# Private Subnets
resource "aws_subnet" "private" {
  for_each = {
    for i, s in var.private_subnets :
    s.az => s
  }

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = false
  availability_zone       = each.value.az

  tags = {
    Name = format("${var.name_prefix}-private-subnet-${each.value.az}")
  }
}
