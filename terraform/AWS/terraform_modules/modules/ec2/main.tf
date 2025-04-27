
resource "aws_instance" "ec2" {
  ami = data.aws_ami.ec2_ami.id
  instance_type = var.instance_type
  # iam_instance_profile = var.microservice_name == "iam_instance" ? var.instance_profile : null
  subnet_id = var.ec2_subnet
  tags = {
    Name = var.microservice_name
  }
}