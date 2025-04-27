resource "aws_security_group" "sg" {
  name        = var.sg_name
  description = "Allow or Deny ports for ${var.project_name}"
  vpc_id      = var.vpc_id

  ingress {
    cidr_blocks         = [var.ipv4_cidr]
    from_port           = var.from_port
    protocol            = var.protocol
    to_port             = var.to_port
  }

  tags = {
    Name = var.sg_name
  }
}




