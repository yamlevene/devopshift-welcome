
variable "ami_id" {
  type    = string
  default = "ami-0e1bed4f06a3b463d"
}

variable "ami_type" {
  type    = string
  default = "t2.micro"
}

variable "instance_name" {
  type    = string
  default = "yam-ec2-machine"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "assign_public_ip" {
  type    = string
  default = true
}
