resource "aws_vpc" "vpc_main" {
  cidr_block = var.cidr
  enable_dns_hostnames = true
  tags = {
    "Name" = "VPC-${var.project}"
    "project" = "${var.project}"
  }
}