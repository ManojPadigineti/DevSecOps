output "ec2_id" {
  value = aws_instance.ec2.id
}

output "ec2_name" {
  value = aws_instance.ec2.key_name
}

output "private_ip" {
  value = aws_instance.ec2.private_ip
}

output "public_ip" {
  value = aws_instance.ec2.public_ip
}