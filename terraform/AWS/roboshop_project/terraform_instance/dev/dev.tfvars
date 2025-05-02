#ami
ami_name = "RHEL-9-DevOps-Practice"
ami_owner = ["973714476881"]
#subnet_id
subnet_id = "subnet-07b912c2ef18bc04b"
#security_group
security_group_id = "sg-0114181433b0be8b2"

terraform_instance = {
  terraform = {
    instance_type = "t2.micro"
  }
}

