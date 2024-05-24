output "public_subnet_ids" {
#  value = aws_subnet.public[element(var.public_subnets[*].az, 0)].id
  value = aws_subnet.public[*].id
}

output "main_route_table_id" {
  value = aws_vpc.this.main_route_table_id
}
