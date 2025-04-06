# VPC
resource "aws_vpc" "project-vpc" {
  cidr_block = var.project-vpc.cidr
  tags = {
    name = var.project-vpc.name
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.project-vpc.id
  tags = { Name = var.igw  }
}

# Public Route Table
resource "aws_route_table" "public" {
  depends_on = [ aws_internet_gateway.igw ]
  vpc_id = aws_vpc.project-vpc.id
  route {
    cidr_block = var.route.cidr_route
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = var.route.name }
}

# Public Subnet
resource "aws_subnet" "public" {
  for_each = var.public_subnet
  vpc_id                  = aws_vpc.project-vpc.id
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = true
  availability_zone       = each.value.av
  tags = { Name = each.value.name }
}

# Private Subnet
resource "aws_subnet" "private" {
  for_each = var.private_subnet
  vpc_id            = aws_vpc.project-vpc.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.av
  tags = { Name = each.value.name }
}

# Associate Public Route Table with Public Subnet
resource "aws_route_table_association" "public_assoc" {
  depends_on = [ aws_subnet.public ]
  for_each = var.public_subnet
  subnet_id  = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public.id
}


############################################################
############################################################
##################### EC 2 #################################
############################################################

# Security Group (allow SSH & ICMP)
resource "aws_security_group" "allow_all_sg" {
  name        = "allow-all-sg"
  description = "Allow all inbound and outbound traffic"
  vpc_id      = aws_vpc.project-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-all-sg"
  }
}


# AMI for Amazon Linux 2
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = ["973714476881"]  # AMI owner ID
  filter {
    name   = "image-id"
    values = ["ami-09c813fb71547fc4f"]
  }
}


# Public EC2 Instance
resource "aws_instance" "public-vm" {
  for_each = var.public-ec2
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = each.value.instance_type
  subnet_id                   = aws_subnet.public[each.value.subnet_id_key].id
  vpc_security_group_ids      = [aws_security_group.allow_all_sg.id]
  associate_public_ip_address = true
  tags = { Name = each.value.name }
}

# Private EC2 Instance
resource "aws_instance" "private_ec2" {
  for_each = var.private-ec2
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = each.value.instance_type
  subnet_id              = aws_subnet.private[each.value.subnet_id_key].id
  vpc_security_group_ids = [aws_security_group.allow_all_sg.id]
  tags = { Name = each.value.name }
}

#End of file