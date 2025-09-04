

module "vpc_main" {
    source = "../modules/vpc"
    project = var.project
    cidr = var.cidr_vpc
}
module "igw_main" {
    source = "../modules/internet_gateway"
    vpc_id = module.vpc_main.vpc_id
}
module "subnet_1" {
    source = "../modules/subnet"
    vpc_id = module.vpc_main.vpc_id
    availability_zone = "${var.region}a" # "us-east-1a"
    subnetcidr    =     cidrsubnet(var.cidr_vpc,8,10) #"18.0.10.0/24"
    identity      =     "a"
    project = var.project
}
module "subnet_2" {
    source = "../modules/subnet"
    vpc_id = module.vpc_main.vpc_id
    availability_zone = "${var.region}b" # "us-east-1b"
    subnetcidr    =     cidrsubnet(var.cidr_vpc,8,20) #"18.0.20.0/24"
    identity      =     "b"
    project = var.project
}
module "route_table" {
    source = "../modules/route_table"
    vpc_id = module.vpc_main.vpc_id
}
module "rta_subnet_1" {
    source = "../modules/rta"
    subnet_id = module.subnet_1.subnet_id
    rt_main_id = module.route_table.rt_main_id  
}
module "rta_subnet_2" {
    source = "../modules/rta"
    subnet_id = module.subnet_2.subnet_id
    rt_main_id = module.route_table.rt_main_id  
}


///   DATA

data "aws_vpc" "vpc_id" {
  filter {
    name   =  "tag:Name"
    values = [var.vpc_name]
  }
  depends_on = [
    module.vpc_main
  ]
}

data "aws_subnet" "subneta" {
  filter {
    name   =  "tag:Name"
    values = [var.subneta_name]
  }
  depends_on = [
    module.subnet_1
  ]
}
data "aws_subnet" "subnetb" {
  filter {
    name   =  "tag:Name"
    values = [var.subnetb_name]
  }
    depends_on = [
    module.subnet_2
  ]
}

data "aws_caller_identity" "current_id" {}


locals {
  subnets = [data.aws_subnet.subneta.id, data.aws_subnet.subnetb.id]
}

// Security
module "segurity_group_task" {
    source = "../modules/security_groups"
    vpc_id = data.aws_vpc.vpc_id.id
    env = var.environment
    project = var.project
}

module "db_subnet_group" {
    source = "../modules/subnet_group"
    project = var.project
    env = var.environment
    subnets = local.subnets
    subneta = data.aws_subnet.subneta.id
    subnetb = data.aws_subnet.subnetb.id
}


module "lb_front" {
    source = "../modules/load_balancer"
    project = var.project
    env = var.environment 
    dev = "front"
    vpc_id = data.aws_vpc.vpc_id.id
    sg-project = module.segurity_group_task.segurity_group_id
    subnets = local.subnets
    subneta = data.aws_subnet.subneta.id
    subnetb = data.aws_subnet.subnetb.id
    td_port = 80
}