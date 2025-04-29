variable "ami_owner" {}
variable "ami_image_name" {}
variable "instances" {}
variable "bucket_name" {}
variable "vpc" {}
variable "subnet" {}
variable "igw_name" {}
variable "nat_private_subnet" {}
variable "nat_name" {}
variable "server_password" {}
variable "ansible_instance" {}
variable "sg_group_configure" {
  type = map(object({
    project_name = string
  }))
}
variable "sg_rules" {
  type = map(object({
    port = number
    protocol = string
    type = string
    cidr = list(string)
  }))
}
variable "microservice" {
  type = list(string)
}