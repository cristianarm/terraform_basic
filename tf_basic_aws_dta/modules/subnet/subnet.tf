resource "aws_subnet" "subnet_i" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnetcidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    "Name" = "${var.project}-subnet-${var.identity}"
    "project" = "${var.project}"
  }
}