module "ec2" {
    source = "./modules/ec2"
    ami_id = "ami-0c02fb55956c7d316"
    instance_type = "t2.micro"
    machine-name = "yam-vm"
    ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
    outgress_port = 0
    outgress_protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]

}

output "print_ec2_info" {
    value = module.ec2
}
