provider "aws" {
  region = "us-east-1"
}

# VPC module
module "vpc" {
  source = "../modules/create_vpc"
}

# security group of ALB
resource "aws_security_group" "alb_sg" {
  name   = "alb-security-group"
  vpc_id = module.vpc.vpc_id

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

# create an application ALB
resource "aws_lb" "my_alb" {
  name               = "yam-app-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = module.vpc.public_subnet_ids
  depends_on = [ module.vpc ]
}

# target group of ALB
resource "aws_lb_target_group" "tg" {
  name     = "yam-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
  target_type = "instance"
}

# listener of ALB
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

# launch template for EC2 machine instances
resource "aws_launch_template" "my_lt" {
  name_prefix   = "yam-launch-template"
  image_id      = "ami-0e1bed4f06a3b463d"
  instance_type = "t2.micro"
  network_interfaces {
    security_groups = [module.vpc.ec2_security_group_id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "yam-auto-scaled-instance"
    }
  }
}

# auto scaling Group
resource "aws_autoscaling_group" "asg" {
  vpc_zone_identifier = module.vpc.public_subnet_ids
  desired_capacity    = 1
  min_size           = 1
  max_size           = 3

  launch_template {
    id      = aws_launch_template.my_lt.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.tg.arn]
}
