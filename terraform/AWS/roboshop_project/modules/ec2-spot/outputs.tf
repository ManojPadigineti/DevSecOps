output "ec2_instance_output_id" {
  value = aws_instance.ec2.id
}

output "ec2_instance_output_public_ip" {
  value = aws_instance.ec2.public_ip
}

output "ec2_instance_output_private_ip" {
  value = aws_instance.ec2.private_ip
}