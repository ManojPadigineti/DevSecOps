vpc = {
  roboshop_vpc = {
    cidr = "14.0.0.0/16"
  }
}

# Subnets
subnets = {
  public-subnet = {
    cidr = "14.0.1.0/16"
  }
  private-subnet = {
    cidr = "14.0.2.0/16"
  }
}

igw = {
  igw-rb = {
    name = "roboshop_igw"
  }
}

# Public Route Table
public_route_table_name  = "roboshop_public_rt"

#public_route
public_route_to_igw_cidr = "0.0.0.0/0"

#Nat_gateway
nat_gateway = {
  roboshop-nat = {
    nat_eip_name = "roboshop_nat-eip"
  }
}