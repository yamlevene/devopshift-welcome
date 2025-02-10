
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  type    = string
  default = "yam-vpc"
}

variable "subnet_count" {
  type    = number
  default = 2
}

variable "public_subnet_name" {
  type    = string
  default = "yam-public-subnet"
}

variable "private_subnet_name" {
  type    = string
  default = "yam-private-subnet"
}

variable "public_subnet_az" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "private_subnet_az" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "public_rt_name" {
  type    = string
  default = "yam-public-route-table"
}

variable "private_rt_name" {
  type    = string
  default = "yam-private-route-table"
}

variable "igw_name" {
  type    = string
  default = "yam-internet-gateway"
}

variable "igw_cidr_block" {
  type    = string
  default = "0.0.0.0/0"
}
