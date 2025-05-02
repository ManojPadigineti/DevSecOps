
#=============#
#     VPC     #
#=============#
module "vpc" {
  for_each = var.vpc
  source = "../modules/vpc"
  cidr = each.value.cidr
  vpc  = each.key
}

#=============#
#     IGW     #
#=============#

module "igw" {
  for_each = var.igw
  source = "../modules/igw"
  igw_name = each.value.name
  vpc_id   = module.vpc["roboshop_vpc"].vpc_id
}



