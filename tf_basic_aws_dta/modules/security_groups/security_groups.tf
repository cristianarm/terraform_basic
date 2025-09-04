resource "aws_security_group" "sg_ecs_tasks" {
  name   = "${var.project}-${var.env}-security_group"
  vpc_id = var.vpc_id
 
  ingress {
   protocol         = "tcp"
   from_port        = 8080
   to_port          = 8090
   cidr_blocks      = [var.cidr_internet]
  }
  ingress {
   protocol         = "tcp"
   from_port        = var.port_http
   to_port          = var.port_http
   cidr_blocks      = [var.cidr_internet]
  }
  ingress {
   protocol         = "tcp"
   from_port        = var.port_https
   to_port          = var.port_https
   cidr_blocks      = [var.cidr_internet]
  }
 
  egress {
   protocol         = "-1"
   from_port        = 0
   to_port          = 0
   cidr_blocks      = [var.cidr_internet]
  }
  tags = {
    "project" = "${var.project}"
    "environment" = "${var.env}"
  }
}

