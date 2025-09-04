#----------------------------------------------------
#         Security
#----------------------------------------------------
# Defining the Public Subnet Security Group
resource "aws_security_group" "tf_sg_public" {
  name = "${var.namespace}-${var.stage}-sg_public"
  description = "Allowing Internet Access"
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name =  "${var.namespace}-${var.stage}-sg_public"
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${chomp(aws_instance.tf_bastion.private_ip)}/32"]
    ##  only bastion IP
  }
    egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  depends_on = [
    aws_instance.tf_bastion
  ]
}


# Defining the public Subnet Security Group to bastion
resource "aws_security_group" "sg_priv_bastion" {
  name = "${var.namespace}-${var.stage}-sg_priv_bastion"
  description = "Restricted Access, only SSH"
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name = "${var.namespace}-${var.stage}-sg_priv_bastion"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    #cidr_blocks = ["0.0.0.0/0"]  # bad praxis, to be restricted to limited ips
    cidr_blocks = ["${chomp(data.http.icanhazip.body)}/32"]   # Only my public IP
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Defining the Private Subnet Security Group
resource "aws_security_group" "sg_to_priv" {
  name = "${var.namespace}-${var.stage}-sg_to_priv"
  description = "Restricted Access"
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name = "${var.namespace}-${var.stage}-sg_to_priv"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${chomp(aws_instance.tf_bastion.private_ip)}/32"]
    ##  only bastion IP
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0"]
  }
  depends_on = [aws_instance.tf_bastion]
}