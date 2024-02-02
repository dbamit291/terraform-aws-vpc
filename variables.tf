variable "name_prefix" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "public_subnets" {
  type = set(object({
    cidr_block = string
    az         = string
  }))
}

variable "private_subnets" {
  type = set(
    object({
      cidr_block = string
      az         = string
    })
  )
}
