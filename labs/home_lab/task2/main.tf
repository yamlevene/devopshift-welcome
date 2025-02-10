provider "aws" {
  region = "us-east-1"
}

module "instance_creator" {
  source = "../modules/create_instance"
}

# output the public IP of the EC2 instance
output "ec2_public_ip" {
  value = module.instance_creator.ec2_public_ip
}
