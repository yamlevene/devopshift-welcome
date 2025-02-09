output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.my_vpc.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = aws_subnet.private_subnet.id
}

output "ec2_security_group_id" {
  value = aws_security_group.ec2_sg.id
}