module "ec2" {
  depends_on = [module.vpc, module.subnet, module.nat]
  for_each = var.instances
  source = "./modules/ec2"
  ami_image_name = var.ami_image_name
  ami_owner = var.ami_owner
  instance_type = each.value.instance_type
  microservice_name = each.key
  ec2_subnet = module.subnet[each.value.ec2_subnet].subnet_id
}

module "eip" {
  depends_on = [module.ec2]
  for_each = { for k, v in var.instances : k => v if v.ec2_subnet == "public_subnet" }
  source = "./modules/eip"
  instance = each.key
  eip_instances = module.ec2[each.key].ec2_id
}

module "eip_associate" {
  depends_on = [module.eip]
  for_each = { for k, v in var.instances : k => v if v.ec2_subnet == "public_subnet" }
  source = "./modules/eip_associate"
  eip_allocate_id = module.eip[each.key].eip_id
  instance_id = module.ec2[each.key].ec2_id
}


module "s3" {
  source = "./modules/s3"
  bucket_name = var.bucket_name
}

module "vpc" {
  for_each = var.vpc
  source = "./modules/vpc"
  cidr = each.value.cidr
  vpc_name = each.key
}

module "subnet" {
  for_each = var.subnet
  source = "./modules/subnet"
  subnet_name = each.key
  subnet_cidr = each.value.subnet_cidr
  vpc_id = module.vpc.roboshop_vpc.vpc_id
}

module "igw" {
  depends_on = [module.vpc]
  source = "./modules/igw"
  vpc_id_igw = module.vpc.roboshop_vpc.vpc_id
  igw_name = var.igw_name
}

module "nat" {
  depends_on = [module.subnet]
  source = "./modules/nat_gateway"
  nat_subnet = module.subnet["public_subnet"].subnet_id
  nat_name = var.nat_name
}

module "route_table" {
  depends_on = [module.vpc, module.subnet]
  source = "./modules/route_table"
  igw_id = module.igw.igw_id
  vpc_id = module.vpc.roboshop_vpc.vpc_id
  public_subnet = module.subnet["public_subnet"].subnet_id
  nat_gateway_id = module.nat.roboshop_nat
  private_subnet = module.subnet["private_subnet"].subnet_id
}

module "route53_record" {
  for_each = var.instances
  source = "./modules/route53"
  hosted_zone_name = "manojpadigineti.cloud"
  instance  = each.key
  record_ip = each.key == "frontend" ? module.ec2[each.key].public_ip : module.ec2[each.key].private_ip
}

module "security_group" {
  for_each = var.sg_conf
  source = "./modules/security_group"
  from_port    = each.value.from_port
  ipv4_cidr    = each.value.ipv4_cidr
  project_name = each.value.project_name
  protocol     = each.value.protocol
  sg_name      = each.value.sg_name
  to_port      = each.value.to_port
  vpc_id       = module.vpc.roboshop_vpc.vpc_id
}

module "ansible_ec2" {
  depends_on = [module.vpc, module.subnet, module.nat]
  for_each = var.ansible_instance
  source = "./modules/ec2"
  ami_image_name = var.ami_image_name
  ami_owner = var.ami_owner
  instance_type = each.value.instance_type
  microservice_name = each.key
  ec2_subnet = module.subnet[each.value.ec2_subnet].subnet_id
}

# server_password - Should pass as runtime variable
module "provisioner" {
  for_each = { for k, v in var.ansible_instance : k => v if k == "ansible"}
  source = "./modules/provisioner"
  password = var.server_password
  server_ip = module.ansible_ec2[each.key].public_ip
}