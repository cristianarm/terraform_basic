locals {
  ingress_rules = [
    {
      port        = 443
      description = "Ingress rules for port 443/https"
    },
    {
      port        = 80
      description = "Ingress rules for port 80/http"
    }
  ]

  ingress_bastion = [
    {
      port        = 22
      description = "Ingress rules for port 22/ssh"
    }

  ]
}

#----------------------------------------------------
#         Security
#----------------------------------------------------

# Defining access from bastion
resource "aws_security_group" "tf_sg_ing_bastion" {
  name        = "${var.namespace}-${var.stage}-sg_bastion"
  description = "Allowing Internet Access"
  vpc_id      = aws_vpc.tf_vpc.id

  tags = {
    Name = "${var.namespace}-${var.stage}-sg_public"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(aws_instance.tf_bastion.private_ip)}/32"]
    ##  only bastion IP
  }
  depends_on = [
    aws_instance.tf_bastion
  ]
}

# Defining enable access by http and https
resource "aws_security_group" "tf_sg_ing_public" {
  name        = "${var.namespace}-${var.stage}-sg_public"
  description = "Allowing Internet Access"
  vpc_id      = aws_vpc.tf_vpc.id

  tags = {
    Name = "${var.namespace}-${var.stage}-sg_public"
  }

  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = [var.cidr_internet]
    }
  }
}



# Defining ingress from bastion
resource "aws_security_group" "sg_ing_bastion" {
  name        = "${var.namespace}-${var.stage}-sg_ing_bastion"
  description = "Restricted Access, only SSH"
  vpc_id      = aws_vpc.tf_vpc.id

  tags = {
    Name = "${var.namespace}-${var.stage}-sg_ing_bastion"
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    #cidr_blocks = ["0.0.0.0/0"]  # bad praxis, to be restricted to limited ips
    cidr_blocks = ["${chomp(data.http.icanhazip.body)}/32"] # Only my public IP
  }

}


#----------------------------------------------

# Defining enable egress to internet
resource "aws_security_group" "sg_egr_internet" {
  name        = "${var.namespace}-${var.stage}-sg_egr_internet"
  description = "Restricted Access"
  vpc_id      = aws_vpc.tf_vpc.id

  tags = {
    Name = "${var.namespace}-${var.stage}-sg_egr_internet"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_internet]
  }
}