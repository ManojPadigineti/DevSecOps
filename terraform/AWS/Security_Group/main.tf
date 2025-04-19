data "aws_security_group" "sg" {
  name = var.sg_name

}

resource "aws_vpc_security_group_ingress_rule" "delete_TCP" {
  security_group_id = data.aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 0
  ip_protocol       = "tcp"
  to_port           = 65535
}



