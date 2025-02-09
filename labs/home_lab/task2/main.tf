provider "aws" {
  region = "us-east-1"
}

module "instance_creator" {
  source = "../modules/create_instance"
  vpc_cidr = "10.0.0.0/16"
  instance_type = "t2.micro"
  assign_public_ip = true
  subnet_count = 2
}

# output the public IP of the EC2 instance
output "ec2_public_ip" {
  value       = module.instance_creator.ec2_public_ip
}
