# Terraform Variables
project-vpc = {
  "cidr" = "10.0.0.0/16",
  "name" = "Roboshop-vpc"
}

igw = "roboshop-igw"

route = {
  "cidr_route" = "0.0.0.0/0",
  "name" = "robo_public_route"
}

public_subnet = {
  "rb-public-subnet" = {
    name = "rb-public-sub"
    cidr = "10.0.1.0/24" 
    av = "us-east-1a"
  }
}

private_subnet = {
  "rb-private-subnet" = {
    name = "rb-private-sub"
    cidr = "10.0.2.0/24" 
    av = "us-east-1a"
  }
}

# ami = {
#   name = "RHEL-9-DevOps-Practice"
#   values = "ami-008e7b65af911ed5c"
# }

public-ec2 = {
  "Frontend-server" = {
    instance_type = "t2.micro"
    subnet_id_key = "rb-public-subnet"
    name = "frontend-server"
  }
}



private-ec2 = {
  "catalogue-server" = {
    instance_type = "t2.micro"
    subnet_id_key = "rb-private-subnet"
    name = "rb-catalogue-server"
  }
  # "mongodb-server" = {
  #   instance_type = "t2.micro"
  #   subnet_id_key = "rb-private-subnet"
  #   name = "rb-mongodb-server"
  # }
  # "redis-server" = {
  #   instance_type = "t2.micro"
  #   subnet_id_key = "rb-private-subnet"
  #   name = "rb-redis-server"
  # }
  # "user-server" = {
  #   instance_type = "t2.micro"
  #   subnet_id_key = "rb-private-subnet"
  #   name = "rb-user-server"
  # }
  # "cart-server" = {
  #   instance_type = "t2.micro"
  #   subnet_id_key = "rb-private-subnet"
  #   name = "rb-cart-server"
  # }
  # "mysql-server" = {
  #   instance_type = "t2.micro"
  #   subnet_id_key = "rb-private-subnet"
  #   name = "rb-mysql-server"
  # }
  # "shipping-server" = {
  #   instance_type = "t2.micro"
  #   subnet_id_key = "rb-private-subnet"
  #   name = "rb-shipping-server"
  # }
  # "rabbitmq-server" = {
  #   instance_type = "t2.micro"
  #   subnet_id_key = "rb-private-subnet"
  #   name = "rb-rabbitmq-server"
  # }
  # "payment-server" = {
  #   instance_type = "t2.micro"
  #   subnet_id_key = "rb-private-subnet"
  #   name = "rb-payment-server"
  # }
  # "dispatch-server" = {
  #   instance_type = "t2.micro"
  #   subnet_id_key = "rb-private-subnet"
  #   name = "rb-dispatch-server"
  # }
}