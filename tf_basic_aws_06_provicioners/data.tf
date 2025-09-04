
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
