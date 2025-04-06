variable "project-vpc" {
  type = object({
    cidr = string
    name = string
  })
}


variable "igw" {
  type = string
}

variable "route" {
  type = map(string)
}

variable "public_subnet" {
  type = map(object({
    name = string
    cidr = string
    av = string
  }))
}


variable "private_subnet" {
  type = map(object({
    name = string
    cidr = string
    av = string
  }))
}

# variable "ami" {
#   type = object({
#     name = string
#     values = string
#   })
# }

# variable "ami" {
#   type = map(object({
#     name = string
#     values = list(string)
#   }))
# }

variable "public-ec2" {
  type = map(object({
    instance_type = string
    subnet_id_key = string
    name = string
  }))
}

variable "private-ec2" {
  type = map(object({
    instance_type = string
    subnet_id_key = string
    name = string
  }))
}