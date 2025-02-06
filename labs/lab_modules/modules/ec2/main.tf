provider "aws" {
 region = var.region
}


variable "region" {
 default = "us-east-1"
}


# Mocked IP var
variable "emptyip" {
   default = ""
}

variable "ingress_rules" {
  description = "List of ingress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "outgress_port" {
  
}

variable "outgress_protocol" {
  
}

variable "cidr_blocks" {
  
}

resource "aws_security_group" "sg" {
 dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

 
 egress {
   from_port   = var.outgress_port
   to_port     = var.outgress_port
   protocol    = var.outgress_protocol
   cidr_blocks = var.cidr_blocks
 }
}


variable "ami_id" {
  
}

variable "instance_type" {

}

variable "machine-name" {
    
 }


resource "aws_instance" "vm" {
#   ami           = "ami-0c02fb55956c7d316"
 ami = var.ami_id
 instance_type = var.instance_type


 vpc_security_group_ids = [aws_security_group.sg.id]
 
 tags = {
   Name = var.machine-name
 }
}


resource "null_resource" "check_public_ip" {
 provisioner "local-exec" {
   command = <<EOT
     if [ -z "${aws_instance.vm.public_ip}" ]; then
       echo "ERROR: Public IP address was not assigned." >&2
       exit 1
       else
       echo "We got the IP! ${aws_instance.vm.public_ip}"
     fi
   EOT
 }


 depends_on = [aws_instance.vm]
}

output "ingress_rules" {
  value = var.ingress_rules
}

output "the_region" {
  value = var.region
}

output "the_ami_id" {
 value = var.ami_id
}

output "the_vm_public_ip" {
 value       = aws_instance.vm.public_ip
 description = "Public IP address of the VM"
 depends_on = [ null_resource.check_public_ip ]
}