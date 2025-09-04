module "prod_vpc" {
  source = "../modules/vpc"

  vpc_cidr_block           = var.prod_vpc_cidr_block
  vpc_enable_dns_hostnames = var.prod_vpc_enable_dns_hostnames
  vpc_tags                 = var.prod_vpc_tags
  vpc_pub_subnets          = var.prod_vpc_pub_subnets
  vpc_name                 = var.prod_name_vpc
  name_subnet_nat          = var.prod_vpc_pub_subnets[0].name
  vpc_pri_subnets          = var.prod_vpc_pri_subnets
}

module "prod_ec2" {
  source = "../modules/ec2"

  ec2_ami          = data.aws_ami.amazon-linux-2.id
  #vpc_id           = module.prod_vpc.this_vpc_id
  sub_pub_ids      = module.prod_vpc.this_sub_pub
  sub_pri_ids      = module.prod_vpc.this_sub_pri
  key_name         = var.prod_key_name
  tags             = var.prod_vpc_tags
  ec2_name_default = var.prod_ec2_name_default
}