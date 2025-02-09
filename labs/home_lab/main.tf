provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source              = "./modules/create_vpc"
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



# provider "aws" {
#   region = "us-east-1"
# }

# # create a VPC
# resource "aws_vpc" "my_vpc" {
#   cidr_block = "10.0.0.0/16"
#   enable_dns_support = true
#   enable_dns_hostnames = true
#   tags = { Name = "yam-VPC" }
# }

# # create a public subnet
# resource "aws_subnet" "public_subnet" {
#   vpc_id                  = aws_vpc.my_vpc.id
#   cidr_block              = "10.0.1.0/24"
#   map_public_ip_on_launch = true
#   availability_zone       = "us-east-1a"
#   tags = { Name = "yam-public-subnet" }
# }

# # create a private subnet
# resource "aws_subnet" "private_subnet" {
#   vpc_id                  = aws_vpc.my_vpc.id
#   cidr_block              = "10.0.2.0/24"
#   availability_zone       = "us-east-1b"
#   tags = { Name = "yam-private-subnet" }
# }

# # create an internet gateway
# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.my_vpc.id
#   tags = { Name = "yam-internet-gateway" }
# }

# # create a public route table and route to the internet gateway
# resource "aws_route_table" "public_rt" {
#   vpc_id = aws_vpc.my_vpc.id
#   tags = { Name = "yam-public-route-table" }
# }

# resource "aws_route" "public_internet_access" {
#   route_table_id         = aws_route_table.public_rt.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.igw.id
# }

# # add public route table to public subnet
# resource "aws_route_table_association" "public_assoc" {
#   subnet_id      = aws_subnet.public_subnet.id
#   route_table_id = aws_route_table.public_rt.id
# }

# # create a privater route table
# resource "aws_route_table" "private_rt" {
#   vpc_id = aws_vpc.my_vpc.id
#   tags = { Name = "yam-private-route-table" }
# }

# # add private route table to private subnet
# resource "aws_route_table_association" "private_assoc" {
#   subnet_id      = aws_subnet.private_subnet.id
#   route_table_id = aws_route_table.private_rt.id
# }
