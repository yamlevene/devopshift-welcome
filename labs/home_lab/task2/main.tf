provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "../modules/create_vpc"
}

# create EC2 instance (public subnet)
resource "aws_instance" "my_ec2" {
  ami           = "ami-0e1bed4f06a3b463d"
  instance_type = "t2.micro"
  subnet_id     = module.vpc.public_subnet_id
  associate_public_ip_address = true
  security_groups = [module.vpc.ec2_security_group_id]

  tags = {
    Name = "yam-ec2-machine"
  }
}

# output the public IP of the EC2 instance
output "ec2_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.my_ec2.public_ip
}
