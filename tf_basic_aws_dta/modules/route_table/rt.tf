resource "aws_route_table" "rt_main" {
  vpc_id = var.vpc_id
  tags = {
    "Name"    = "${var.project}-rt"
    "project" = "${var.project}"
  }
}
