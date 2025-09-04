#----------------------------------------------------
#         Cumputed
#----------------------------------------------------
# server web
resource "aws_instance" "tf_app_server" {
  ami                         = data.aws_ami.amazon-linux-2.id
  subnet_id                   = aws_subnet.tf_pub-sn.id
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  user_data                   = file("ud_httpd.sh")
  vpc_security_group_ids      = [aws_security_group.tf_sg_ing_bastion.id, 
                                aws_security_group.sg_egr_internet.id]
  associate_public_ip_address = true

  tags = {
    Name = "${var.namespace}-${var.stage}-app_server"
  }

  root_block_device {
    volume_size = "30"
    encrypted   = false
  }
}

# bastion
resource "aws_instance" "tf_bastion" {
  ami                         = data.aws_ami.amazon-linux-2.id
  subnet_id                   = aws_subnet.tf_pub-sn.id
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.sg_ing_bastion.id]
  associate_public_ip_address = true

  tags = {
    Name = "${var.namespace}-${var.stage}-bastion"
  }

  root_block_device {
    volume_size = "30"
    encrypted   = false
  }
}

resource "aws_instance" "tf_backend" {
  count = 3
  ami                    = data.aws_ami.amazon-linux-2.id
  subnet_id              = aws_subnet.pri-sub.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  monitoring             = true
  user_data              = file("ud_httpd.sh")
  vpc_security_group_ids = [aws_security_group.tf_sg_ing_bastion.id, 
                                aws_security_group.sg_egr_internet.id]

  tags = {
    Name = "${var.namespace}-${var.stage}-backend"
  }

  root_block_device {
    volume_size = "30"
    encrypted   = false
  }
}

