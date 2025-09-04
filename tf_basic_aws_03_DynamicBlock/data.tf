# How to Get the Latest OS AMI Id in AWS using Terraform
# https://gmusumeci.medium.com/how-to-get-the-latest-os-ami-in-aws-using-terraform-5b1fca82daff
# Get latest Amazon Linux 2 AMI
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

data "aws_ami" "ubuntu-20" {
  most_recent = true
  #owners      = ["679593333241"]
  owners = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu-minimal/images/hvm-ssd/ubuntu-focal-20.04-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


data "http" "icanhazip" {
  url = "http://ipv4.icanhazip.com"
  # ipv4.icanhazip.com or ipv6.icanhazip.com
}