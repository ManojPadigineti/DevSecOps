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