variable "name_prefix" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = set(string)
}

variable "main_route_table_id" {
  type = string
}
