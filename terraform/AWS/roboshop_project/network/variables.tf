variable "vpc" {
  type = map(object({
    cidr = string
  }))
}

variable "igw" {
  type = map(object({
    name = string
  }))
}


variable "public_route_table_name" {
  type = string
}

variable "public_route_to_igw_cidr" {
  type = string
}

variable "subnets" {
  type = map(object({
    cidr = string
  }))
}

variable "nat_gateway" {
  type = map(object({
    nat_eip_name = string
  }))
}