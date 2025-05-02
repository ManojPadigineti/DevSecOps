#=============#
#     VPC     #
#=============#
module "vpc" {
  for_each = var.vpc
  source = "../modules/vpc"
  cidr = each.value.cidr
  vpc  = each.key
}

#================#
#     Subnet     #
#================#

module "subnets" {
  depends_on = [module.vpc]
  for_each = var.subnets
  source = "../modules/subnets"
  cidr        = each.value.cidr
  subnet_name = each.key
  vpc_id      = module.vpc["roboshop_vpc"].vpc_id
}

#=============#
#     IGW     #
#=============#

module "igw" {
  depends_on = [module.vpc]
  for_each = var.igw
  source = "../modules/igw"
  igw_name = each.value.name
  vpc_id   = module.vpc["roboshop_vpc"].vpc_id
}

#=======================#
#     Route Table       #
#=======================#

module "route_table" {
  depends_on = [module.igw, module.nat]
  source = "../modules/route_table"
  igw_id = module.igw.igw_id
  nat_gateway_id = module.nat["roboshop-nat"].nat_gateway_id
  vpc_id = module.vpc["roboshop_vpc"].vpc_id
}

#============================#
#     Route_association      #
#============================#

module "route_table_association" {
  depends_on = [module.route_table]
  source = "../modules/route_table_association"
  private_subnet      = module.subnets["private-subnet"].subnet_id
  public_subnet       = module.subnets["public-subnet"].subnet_id
  route_table_id_IGW  = module.route_table.igw_route_table_id
  route_table_id__NAT = module.route_table.NAT_route_table_id
}

#======================#
#     NAT_Gateway      #
#======================#

module "nat" {
  depends_on = [module.subnets]
  for_each = var.nat_gateway
  source = "../modules/nat"
  nat_eip_name   = each.value.nat_eip_name
  nat_name      =  each.key
  private_subnet_nat = module.subnets["private-subnet"].subnet_id
}