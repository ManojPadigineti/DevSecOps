module "security_group" {
  for_each = var.sg_group_configure
  source = "./modules/security_group"
  project_name = each.value.project_name
  security_group_name = each.key
vpc_id = module.vpc.roboshop_vpc.vpc_id
}

module "security_group_rule" {
  depends_on = [module.security_group]
  for_each = var.sg_rules
  source = "./modules/security_group_rules"
  port   = each.value.port
  protocol = each.value.protocol
  sg_id = module.security_group["robo-sg"].sg_id
  type = each.value.type
  cidr  = each.value.cidr
}

module "ec2" {
  depends_on = [module.vpc, module.subnet, module.nat, module.security_group]
  for_each = var.instances
  source = "./modules/ec2"
  ami_image_name = var.ami_image_name
  ami_owner = var.ami_owner
  instance_type = each.value.instance_type
  microservice_name = each.key
  ec2_subnet = module.subnet[each.value.ec2_subnet].subnet_id
  security_group = module.security_group.robo-sg.sg_id
}

module "ansible_ec2" {
  depends_on = [module.vpc, module.subnet, module.nat, module.security_group]
  for_each = var.ansible_instance
  source = "./modules/ec2"
  ami_image_name = var.ami_image_name
  ami_owner = var.ami_owner
  instance_type = each.value.instance_type
  microservice_name = each.key
  ec2_subnet = module.subnet[each.value.ec2_subnet].subnet_id
  security_group = module.security_group.robo-sg.sg_id
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

module "verify_public_ip" {
  depends_on = [module.ec2]
  source = "./modules/null_resource"
  public_ip = module.ec2["frontend"].public_ip
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



module "eip_ansible" {
  depends_on = [module.ansible_ec2]
  for_each = { for k, v in var.ansible_instance : k => v if v.ec2_subnet == "public_subnet" }
  source = "./modules/eip"
  instance = each.key
  eip_instances = module.ansible_ec2[each.key].ec2_id
}

module "eip_associate_ansible" {
  depends_on = [module.eip_ansible]
  for_each = { for k, v in var.ansible_instance : k => v if v.ec2_subnet == "public_subnet" }
  source = "./modules/eip_associate"
  eip_allocate_id = module.eip_ansible[each.key].eip_id
  instance_id = module.ansible_ec2[each.key].ec2_id
}

# server_password - Should pass as runtime variable
module "provisioner" {
  depends_on = [module.eip_ansible, module.eip_associate_ansible, module.verify_public_ip]
  for_each = { for k, v in var.ansible_instance : k => v if k == "ansible"}
  source = "./modules/provisioner"
  password = var.server_password
  server_ip = module.ansible_ec2[each.key].public_ip
}

module "route53_record" {
  depends_on = [module.ec2, module.eip, module.provisioner, module.eip_associate, module.verify_public_ip]
  for_each = var.instances
  source = "./modules/route53"
  hosted_zone_name = "manojpadigineti.cloud"
  instance  = each.key
  record_ip = each.key == "frontend" ? module.ec2[each.key].public_ip : module.ec2[each.key].private_ip
}