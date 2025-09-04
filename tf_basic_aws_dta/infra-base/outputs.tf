output "subnet2" {
  value = module.subnet_2.subnet_id
}
output "subnet1" {
  value = module.subnet_1.subnet_id
}

output "subnetbid" {
  value = data.aws_subnet.subnetb.id
}

output "subnetdid" {
  value = data.aws_subnet.subneta.id
}
output "vpcid" {
  value = module.vpc_main.vpc_id
} 

output "datavpcid" {
  value = data.aws_vpc.vpc_id.id
}

output "account_id" {
  value = data.aws_caller_identity.current_id.account_id
}

output "subnets" {
  value = local.subnets
}