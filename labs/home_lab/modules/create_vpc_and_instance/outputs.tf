

output "ec2_public_ip" {
  value = aws_instance.my_ec2.public_ip
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "ec2_security_group_id" {
  value = module.vpc.ec2_security_group_id
}
