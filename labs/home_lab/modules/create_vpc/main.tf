
# create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

# create public subnets dynamically
resource "aws_subnet" "public_subnet" {
  count = var.subnet_count

  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index + 1)
  availability_zone       = var.public_subnet_az[count.index % length(var.public_subnet_az)]

  map_public_ip_on_launch = true

  tags = {
    Name = "${var.public_subnet_name}-${count.index + 1}"
  }
}

# create private subnets dynamically
resource "aws_subnet" "private_subnet" {
  count = var.subnet_count

  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, var.subnet_count + count.index + 1)
  availability_zone = var.private_subnet_az[count.index % length(var.private_subnet_az)]


  tags = {
    Name = "${var.private_subnet_name}-${count.index + 1}"
  }
}

# create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = var.igw_name
  }
}

# create public route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = var.public_rt_name
  }
}

# route to the internet via IGW
resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = var.igw_cidr_block
  gateway_id             = aws_internet_gateway.igw.id
}

# add public route table to public subnets
resource "aws_route_table_association" "public_assoc" {
  count = var.subnet_count

  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

# create private route table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = var.private_rt_name
  }
}

# add private route table to private subnets 
resource "aws_route_table_association" "private_assoc" {
  count = var.subnet_count

  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_rt.id
}

# create security group
resource "aws_security_group" "ec2_sg" {
  name   = "yam-sg"
  vpc_id = aws_vpc.my_vpc.id

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
