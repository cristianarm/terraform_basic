resource "aws_lb" "main" {
  name               = "${var.project}-lb-${var.env}-${var.dev}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg-project]
  subnets = var.subnets
  #subnets            = [ "${var.subneta}" , "${var.subnetb}"]
  enable_deletion_protection = false
  tags = {
    "project" = "${var.project}"
    "environment" = "${var.env}"
    "dev" = "${var.dev}"
  }
}