locals {
  public_route_table_id = aws_vpc.this.main_route_table_id
}

# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = format("${var.name_prefix}-igw")
  }
}

# Update VPC's main Route Table - add IGW route
resource "aws_route" "public" {
  route_table_id = local.public_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.this.id
}

# Public Subnet Route Table Associations
resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = local.public_route_table_id
}
