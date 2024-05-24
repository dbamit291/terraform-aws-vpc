locals {
  public_route_table_id = aws_vpc.this.main_route_table_id
}

# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = var.vpc_id

  tags = {
    Name = format("${var.name_prefix}-igw")
  }
}

import {
  to = aws_route_table.public
  id = var.main_route_table_id
}


# Create Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = format("${var.name_prefix}-public-rt")
  }
}

# Update VPC's main Route Table - add IGW route
#resource "aws_route" "public" {
#  route_table_id = local.public_route_table_id
#  destination_cidr_block = "0.0.0.0/0"
#  gateway_id = aws_internet_gateway.this.id
#}

# Public Subnet Route Table Associations
resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = local.public_route_table_id
}
