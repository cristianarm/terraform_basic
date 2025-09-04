module "vpc"{
    source                          = "../../modules/vpc"

    vpc_name                        = "dev01-vpc"
    vpc_cidr_block                  = "10.0.0.0/16"
    vpc_enable_dns_hostnames        = "true"
    vpc_enable_dns_support          = "true"
    vpc_enable_ipv6                 = "true"
    #vpcenvironment                  = "Development-Engineering"

}