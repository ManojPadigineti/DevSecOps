#ami
ami_name = "RHEL-9-DevOps-Practice"
ami_owner = ["973714476881"]
#subnet_id
public_subnet_id = "subnet-034d799be30689a26"
private_subnet_id = "subnet-05d7fdc9c23b02919"
#security_group
security_group_id = "sg-0100d26ff800ad636"

terraform_instance = {
  terraform = {
    instance_type = "t2.micro"
  }
}
