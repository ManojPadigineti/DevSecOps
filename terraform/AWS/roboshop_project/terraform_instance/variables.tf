#data_sources
variable "ami_name" {}
variable "ami_owner" {}
variable "subnet_id" {}
variable "security_group_id" {}
variable "private_subnet_id" {}

variable "terraform_instance" {
  type = map(object({
    instance_type = string
  }))
}

variable "private_instance" {
  type = map(object({
    instance_type = string
  }))
}