provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "../modules/create_vpc"
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  value = module.vpc.private_subnet_id
}
