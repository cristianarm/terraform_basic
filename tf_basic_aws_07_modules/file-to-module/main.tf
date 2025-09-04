module "vpc_sns" {
  source = "./modulo/vpc_sn/"
  namespace = var.namespace
  stage     = var.stage
}


resource "aws_security_group" "sg_public" {
  name = "${var.namespace}-${var.stage}-sg_public"
  description = "Allowing Internet Access"
  vpc_id = module.vpc_sns.vpc_id

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
    cidr_blocks = [ "${chomp(data.http.icanhazip.body)}/32"]   # Only my public IP
    ##  only bastion IP
  }
    egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  depends_on = [module.vpc_sns ]
}
#  https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest
module "ec2" {
  source = "terraform-aws-modules/ec2-instance/aws"
    
  for_each = toset(["one", "two", "three"])

  name = "instance-${each.key}"

  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  monitoring             = true
  user_data = file("ud_httpd.sh")

  vpc_security_group_ids = [aws_security_group.sg_public.id]
  associate_public_ip_address = true

  subnet_id              = module.vpc_sns.sb_publ_id

  depends_on = [aws_security_group.sg_public ]
}
