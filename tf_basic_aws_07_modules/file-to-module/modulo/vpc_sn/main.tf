locals {
  cidr_sn1 = cidrsubnet(var.cidr,4,0)
  cidr_sn2 = cidrsubnet(var.cidr,4,1)
}
#----------------------------------------------------
#         Networking
#----------------------------------------------------

# -------------  VPC/Subnets -------------
# Defining the VPC
resource "aws_vpc" "tf_vpc" {
  cidr_block          = var.cidr
  instance_tenancy    = var.instance_tenancy
  enable_dns_hostnames  = var.enable_dns_hostnames
  enable_dns_support    = var.enable_dns_support

  tags = {
    Name = "${var.namespace}-${var.stage}-vpc"
  }
}
# Defining the VPC Subnets
# Subnet Public
resource "aws_subnet" "tf_pub-sn" {
  cidr_block = local.cidr_sn1 
  vpc_id = aws_vpc.tf_vpc.id
  #availability_zone = var.avzone
  #map_public_ip_on_launch = true

  tags = {
    Name = "${var.namespace}-${var.stage}-pub-sub"
  }
}

# Subnet Private
resource "aws_subnet" "pri-sub" {
  cidr_block =  local.cidr_sn2 
  vpc_id = aws_vpc.tf_vpc.id
  #availability_zone = var.avzone

  tags = {
    Name = "${var.namespace}-${var.stage}-priv-sub"
  }
}

# -------------   Gateway -------------
# Defining the VPC Internet Gateway
resource "aws_internet_gateway" "tf_igw" {
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name = "${var.namespace}-${var.stage}-vpc_igw"
  }
}

# Defining the Elastic IP Address for NAT
resource "aws_eip" "tf_eip" {
  vpc      = true
  tags = {
    Name  = "${var.namespace}-${var.stage}-eip_nat"
  }
}

# Defining the VPC NAT Gateway
resource "aws_nat_gateway" "tf_vpc_nat" {
  allocation_id = aws_eip.tf_eip.id
  subnet_id     = aws_subnet.tf_pub-sn.id
  depends_on = [aws_internet_gateway.tf_igw]

  tags = {
    Name = "${var.namespace}-${var.stage}-vpc_nat"
  }
}

# -------------   Routes public subnet -------------
# Defining the route table for public subnet
resource "aws_route_table" "pub-route" {
  vpc_id = aws_vpc.tf_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_igw.id
  }

  tags = {
    Name = "${var.namespace}-${var.stage}-public_route"
  }
}
# Associating the Public subnet to the Internet exposed route table
resource "aws_route_table_association" "aws_rt_association" {
  route_table_id = aws_route_table.pub-route.id
  subnet_id = aws_subnet.tf_pub-sn.id
}

# -------------   Routes private subnet -------------
# Defining the route table for private subnet
resource "aws_route_table" "pri-route" {
  vpc_id = aws_vpc.tf_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.tf_vpc_nat.id
  }

  tags = {
    Name = "${var.namespace}-${var.stage}-priv_route"
  }
}

resource "aws_route_table_association" "aws_rt_association2" {
  route_table_id = aws_route_table.pri-route.id
  subnet_id = aws_subnet.pri-sub.id
}
