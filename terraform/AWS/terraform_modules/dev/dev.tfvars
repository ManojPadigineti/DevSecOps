ami_image_name = "RHEL-9-DevOps-Practice"
ami_owner = "973714476881"
bucket_name = "manojtf99"

# Instance
instances = {
  frontend = {
    instance_type = "t2.micro"
    ec2_subnet = "public_subnet"
  }
  mongodb = {
    instance_type = "t2.micro"
    ec2_subnet = "private_subnet"
  }
  catalogue = {
    instance_type = "t2.micro"
    ec2_subnet = "private_subnet"
  }
}

# Ansible Instance
ansible_instance = {
  ansible = {
    instance_type = "t2.micro"
    ec2_subnet = "public_subnet"
  }
}

vpc = {
  roboshop_vpc = {
    cidr = "15.0.0.0/16"
  }
}

subnet = {
  public_subnet = {
    subnet_cidr = "15.0.1.0/24"
  }
  private_subnet = {
    subnet_cidr = "15.0.2.0/24"
  }
}

# IGW
igw_name = "roboshop_igw"

#NAT
nat_name = "roboshop-nat"
nat_private_subnet = "public_subnet"


#security_group_configuration
sg_conf = {
  ssh = {
    sg_name = "roboshop-sg"
    project_name = "roboshop"
    ipv4_cidr = "106.212.230.8/32"
    from_port = "22"
    protocol = "TCP"
    to_port = "22"
  }
}


