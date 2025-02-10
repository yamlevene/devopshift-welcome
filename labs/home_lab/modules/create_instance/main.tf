

# create EC2 instance
resource "aws_instance" "my_ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  associate_public_ip_address = var.assign_public_ip

  tags = {
    Name = var.instance_name
  }
}
