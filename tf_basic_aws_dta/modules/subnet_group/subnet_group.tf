resource "aws_db_subnet_group" "main" {
  name       = "${var.project}-${var.env}"
  subnet_ids = var.subnets

  tags = {
    "Name" = "${var.project} subnet group "
    "environment" = "${var.env}"
    "project" = "${var.project}"
  }
}