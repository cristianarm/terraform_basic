resource "aws_route_table_association" "rta-2" {
  subnet_id      = var.subnet_id
  route_table_id = var.rt_main_id
}