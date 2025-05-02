module "terraform_ec2" {
  for_each = var.terraform_instance
  source = "../modules/ec2"
  ami    = data.aws_ami.ami_ec2.id
  ec2_subnet = data.aws_subnet.public_subnet.id
  instance_name = each.key
  instance_type = each.value.instance_type
  security_group = data.aws_security_group.security_group.id
}

module "eip" {
  depends_on = [module.terraform_ec2]
  for_each = var.terraform_instance
  source = "../modules/eip"
  instance_id = module.terraform_ec2[each.key].ec2_instance_output_id
}