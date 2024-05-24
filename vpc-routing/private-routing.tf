locals {
  first_public_subnet = var.public_subnet_ids[0]
}

# Elastic IP for NAT Gateway
resource "aws_eip" "this" {
  depends_on = [aws_internet_gateway.this]

  tags = {
    Name = format("${var.name_prefix}-eip")
  }
}

# NAT Gateway
resource "aws_nat_gateway" "this" {
  depends_on    = [aws_internet_gateway.this]
  allocation_id = aws_eip.this.id
  subnet_id     = local.first_public_subnet

  tags = {
    Name = format("${var.name_prefix}-nat")
  }
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }

  tags = {
    Name = format("${var.name_prefix}-private-rt")
  }
}

# Private Subnet Route Table Associations
resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}
