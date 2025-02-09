
# create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = { Name = var.vpc_name }
}

# create a public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.public_subnet_az
  tags = { Name = var.public_subnet_name }
}

# create a private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.private_subnet_cidr
  availability_zone       = var.private_subnet_az
  tags = { Name = var.private_subnet_name }
}

# create an internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = { Name = var.igw_name }
}

# create a public route table and route to the internet gateway
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id
  tags = { Name = var.public_rt_name }
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = var.igw_cidr_block
  gateway_id             = aws_internet_gateway.igw.id
}

# add public route table to public subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# create a privater route table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.my_vpc.id
  tags = { Name = var.private_rt_name }
}

# add private route table to private subnet
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_security_group" "ec2_sg" {
  name        = "yam-sg"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
