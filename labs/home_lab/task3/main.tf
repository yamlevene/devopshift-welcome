provider "aws" {
  region = "us-east-1"
}

module "vpc_and_instance_creator" {
  source = "../modules/create_vpc_and_instance"
  vpc_cidr = "10.0.0.0/16"
  instance_type = "t2.micro"
  assign_public_ip = true
  subnet_count = 2
}

output "ec2_public_ip" {
  value = module.vpc_and_instance_creator.ec2_public_ip
}

output "vpc_ip" {
  value = module.vpc_and_instance_creator.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc_and_instance_creator.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc_and_instance_creator.private_subnet_ids
}

output "ec2_security_group_id" {
  value = module.vpc_and_instance_creator.ec2_security_group_id
}
