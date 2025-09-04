locals {
  cidr_sn1 = cidrsubnet(var.cidr,4,0)
  cidr_sn2 = cidrsubnet(var.cidr,4,1)
}

# ----------------------------------------------------------------------------------------------------
# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  name = "${var.namespace}-${var.stage}-vpc-net"
  cidr = var.cidr
  azs             = [data.aws_availability_zones.availableAZ.names[0], data.aws_availability_zones.availableAZ.names[1]]
  private_subnets = [local.cidr_sn1]
  public_subnets  = [local.cidr_sn2]

    enable_dns_support               = true
  enable_dns_hostnames             = true

  enable_nat_gateway = true
  enable_vpn_gateway = true

}


# ----------------------------------------------------------------------------------------------------
# https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest/submodules/ssh
module "ssh_internal_sg" {
  source  = "terraform-aws-modules/security-group/aws//modules/ssh"
  version = "4.9.0"

  name = "${var.namespace}-${var.stage}-sg-ssh"
  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks      = [ "${chomp(module.ec2-bastion.private_ip)}/32"]    #  only bastion IP

  depends_on = [
    module.ec2-bastion
  ]
}

module "ssh_external_sg" {
  source  = "terraform-aws-modules/security-group/aws//modules/ssh"
  version = "4.9.0"

  name = "${var.namespace}-${var.stage}-sg-ssh"
  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks      = [ "${chomp(data.http.icanhazip.body)}/32"]   # Only my public IP

}

# ----------------------------------------------------------------------------------------------------
# https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest/examples/http
module "http_external_80_sg" {
  source  = "terraform-aws-modules/security-group/aws//modules/http-80"
  version = "4.9.0"

  name = "${var.namespace}-${var.stage}-sg-http"
  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks      = [ var.cidr_internet]  

}

module "http_external_443_sg" {
  source  = "terraform-aws-modules/security-group/aws//modules/https-443"
  version = "4.9.0"

  name = "${var.namespace}-${var.stage}-sg-http"
  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks      = [ var.cidr_internet]  
}

module "http_internal_80_sg" {
  source  = "terraform-aws-modules/security-group/aws//modules/http-80"
  version = "4.9.0"

  name = "${var.namespace}-${var.stage}-sg-http"
  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks      = [ var.cidr]  

}

#-----------------------------------------------------------------------------
# https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest
module "ec2-bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.0.0"

  name = "${var.namespace}-${var.stage}-ec2"

  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  monitoring             = true
  vpc_security_group_ids = [module.ssh_external_sg.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
  associate_public_ip_address = true

  depends_on = [
    module.ssh_external_sg.security_group_id
  ]
}




#  https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest
module "ec2-frondend" {
  source = "terraform-aws-modules/ec2-instance/aws"
    
  for_each = toset(["alfa", "beta", "gamma"])
    
    name = "${var.namespace}-${var.stage}-ec2-frondend-${each.key}"

    ami                    = data.aws_ami.amazon-linux-2.id
    instance_type          = "t2.micro"
    key_name               = var.key_name
    monitoring             = true
    user_data = file("ud_httpd.sh")

    vpc_security_group_ids = [module.http_external_80_sg.security_group_id, module.http_external_443_sg.security_group_id, module.ssh_internal_sg.security_group_id]
    subnet_id              = module.vpc.public_subnets[0]
    associate_public_ip_address = true

  depends_on = [
    module.http_external_80_sg, 
    module.http_external_443_sg,
    module.ssh_internal_sg ]
}


module "ec2-backend" {
  source = "terraform-aws-modules/ec2-instance/aws"
    
  for_each = toset(["omega", "psi", "ji"])
    
    name = "${var.namespace}-${var.stage}-ec2-backend-${each.key}"

    ami                    = data.aws_ami.amazon-linux-2.id
    instance_type          = "t2.micro"
    key_name               = var.key_name
    monitoring             = true
    user_data = file("ud_httpd.sh")

    vpc_security_group_ids = [ module.http_internal_80_sg.security_group_id,  module.ssh_internal_sg.security_group_id]
    subnet_id              = module.vpc.public_subnets[0]
    associate_public_ip_address = true

  depends_on = [
    module.http_internal_80_sg, 
    module.ssh_internal_sg ]
}