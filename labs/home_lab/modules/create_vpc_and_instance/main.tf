
module "vpc" {
  source = "../create_vpc"
  vpc_cidr = var.vpc_cidr
  subnet_count = var.subnet_count
}

# create EC2 instance (public subnet)
resource "aws_instance" "my_ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.vpc.public_subnet_ids[0]
  associate_public_ip_address = var.assign_public_ip
  security_groups = [module.vpc.ec2_security_group_id]

  tags = {
    Name = var.instance_name
  }
}
