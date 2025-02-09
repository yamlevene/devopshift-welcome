variable "vpc_cidr" {
  type        = string
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  type        = string
  default = "yam-vpc"
}

variable "public_subnet_cidr" {
  type        = string
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  type        = string
  default = "10.0.2.0/24"
}

variable "public_subnet_az" {
  type        = string
  default = "us-east-1a"
}

variable "public_subnet_name" {
  type        = string
  default = "yam-public-subnet"
}

variable "public_rt_name" {
  type        = string
  default = "yam-public-route-table"
}

variable "private_subnet_az" {
  type        = string
  default = "us-east-1b"
}

variable "private_subnet_name" {
  type        = string
  default = "yam-private-subnet"
}

variable "private_rt_name" {
  type        = string
  default = "yam-private-route-table"
}

variable "igw_name" {
  type        = string
  default = "yam-internet-gateway"
}

variable "igw_cidr_block" {
  type        = string
  default = "0.0.0.0/0"
}