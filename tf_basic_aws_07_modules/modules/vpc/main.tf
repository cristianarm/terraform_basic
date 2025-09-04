locals {
  cidr_public = cidrsubnet(var.vpc_cidr_block,4,0)
  cidr_priv = cidrsubnet(var.vpc_cidr_block,4,1)
}

resource "aws_vpc" "this" {
  cidr_block            = var.vpc_cidr_block
  instance_tenancy      = var.vpc_instance_tenancy
  enable_dns_hostnames  = var.vpc_enable_dns_hostnames
  enable_dns_support    = var.vpc_enable_dns_support

  tags = merge("${var.vpc_tags}", { "Name" = "${var.vpc_name}" })
}

resource "aws_internet_gateway" "this" {
  depends_on   = [aws_vpc.this]
  vpc_id = aws_vpc.this.id
  tags   = merge("${var.vpc_tags}", { "Name" = "${var.vpc_name}-ing" })
}

// subnets
resource "aws_subnet" "this_sub_pub" {
  depends_on   = [aws_vpc.this]
  for_each = { for v in var.vpc_pub_subnets : v.name => v }

  vpc_id            = aws_vpc.this.id
  cidr_block        = local.cidr_public
  availability_zone = each.value.availability_zone

  tags = merge("${each.value.tags}", { Name = "${var.vpc_name}-${each.key}" })
}

resource "aws_subnet" "this_sub_pri" {
  depends_on   = [aws_vpc.this]
  for_each = { for sp in var.vpc_pri_subnets : sp.name => sp }

  vpc_id            = aws_vpc.this.id
  cidr_block        = local.cidr_priv
  availability_zone = each.value.availability_zone

  tags = merge("${each.value.tags}", { Name = "${var.vpc_name}-${each.key}" })
}

// subnets ########################
// nat gateway ########################
resource "aws_eip" "this" {
  vpc = true
  tags = var.vpc_tags
}
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id = values(aws_subnet.this_sub_pub)[0].id
}

// nat gateway ############################

// route table 
resource "aws_route_table" "this-r-t-pub" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = merge("${var.vpc_tags}", { Name = "${var.vpc_name}-r-t-pub" })
}

resource "aws_route_table" "this-r-t-pri" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }
  tags = merge("${var.vpc_tags}", { Name = "${var.vpc_name}-r-t-pri" })
}

resource "aws_route_table_association" "this-as-pub" {
  count = length(aws_subnet.this_sub_pub)
  route_table_id = aws_route_table.this-r-t-pub.id
  subnet_id      = values(aws_subnet.this_sub_pub)[count.index].id
  depends_on = [aws_subnet.this_sub_pub, aws_route_table.this-r-t-pub]
}

resource "aws_route_table_association" "this-as-pri" {
  count = length(aws_subnet.this_sub_pri)
  route_table_id = aws_route_table.this-r-t-pri.id
  subnet_id      = values(aws_subnet.this_sub_pri)[count.index].id
  depends_on = [aws_subnet.this_sub_pri, aws_route_table.this-r-t-pri]
}