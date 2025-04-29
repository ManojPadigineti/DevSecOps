ami_image_name = "RHEL-9-DevOps-Practice"
ami_owner = "973714476881"
bucket_name = "manojtf99"

microservice = ["frontend", "mongodb", "catalogue", "redis", "user", "cart", "mysql", "shipping", "rabbitmq", "payment", "dispatch"]

# Instance
instances = {
  frontend = {
    instance_type = "t2.micro"
    ec2_subnet = "public_subnet"
    sg_name = "roboshop-sg"
  }
  mongodb = {
    instance_type = "t2.micro"
    ec2_subnet = "private_subnet"
    sg_name = "roboshop-sg"
  }
  catalogue = {
    instance_type = "t2.micro"
    ec2_subnet = "private_subnet"
    sg_name = "roboshop-sg"
  }
  redis = {
    instance_type = "t2.micro"
    ec2_subnet = "private_subnet"
    sg_name = "roboshop-sg"
  }
  user = {
    instance_type = "t2.micro"
    ec2_subnet = "private_subnet"
    sg_name = "roboshop-sg"
  }
  cart = {
    instance_type = "t2.micro"
    ec2_subnet = "private_subnet"
    sg_name = "roboshop-sg"
  }
  mysql = {
    instance_type = "t2.micro"
    ec2_subnet = "private_subnet"
    sg_name = "roboshop-sg"
  }
  shipping = {
    instance_type = "t2.micro"
    ec2_subnet = "private_subnet"
    sg_name = "roboshop-sg"
  }
  rabbitmq = {
    instance_type = "t2.micro"
    ec2_subnet = "private_subnet"
    sg_name = "roboshop-sg"
  }
  payment = {
    instance_type = "t2.micro"
    ec2_subnet = "private_subnet"
    sg_name = "roboshop-sg"
  }
  dispatch = {
    instance_type = "t2.micro"
    ec2_subnet = "private_subnet"
    sg_name = "roboshop-sg"
  }
}

# Ansible Instance
ansible_instance = {
  ansible = {
    instance_type = "t2.micro"
    ec2_subnet = "public_subnet"
    sg_name = "roboshop-sg"
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
sg_group_configure = {
  robo-sg = {
    project_name = "roboshop"
  }
}

#Security_group_rules
sg_rules = {
  http = {
    port = 80
    protocol = "TCP"
    type = "ingress"
    cidr = ["0.0.0.0/0"]
  }
  ssh = {
    port = 22
    protocol = "TCP"
    type = "ingress"
    cidr = ["122.174.98.221/32"]
  }
  sonar = {
    port = 9000
    protocol = "TCP"
    type = "ingress"
    cidr = ["0.0.0.0/0"]
  }
  jenkins = {
    port = 8080
    protocol = "TCP"
    type = "ingress"
    cidr = ["0.0.0.0/0"]
  }
  egress = {
    port = 0
    protocol = "-1"
    type = "egress"
    cidr = ["0.0.0.0/0"]
  }
}

