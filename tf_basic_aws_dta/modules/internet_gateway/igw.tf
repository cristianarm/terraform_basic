resource "aws_internet_gateway" "igw_main" {
  vpc_id = var.vpc_id
  tags = {
    "Name" = "${var.project}-igw"
  }
}