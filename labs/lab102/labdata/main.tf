provider "aws" {
  region = var.region
}

variable "region" {
  default = "us-east-1"
}

data "aws_instances" "vms" {
  filter {
    name = "tag:Name"
    values = ["yaniv-vm"]
  }
}

data "aws_instance" "yaniv_vm" {
  instance_id = "i-09df7e0ed385f871b"
}

data "aws_ami" "yaniv_ami" {
  owners = ["self"]
  filter {
    name = "name"
    values = ["terraform-workshop-image-do-not-delete"]
  }
}

output "yaniv_ami_id" {
  value = data.aws_ami.yaniv_ami
}

# output "public_ip" {
#   value = data.aws_instances.vms.public_ips
# }

# output "public_ip" {
#   value = data.aws_instance.yaniv_vm.public_ips
# }