/* output "az" {
    value = [data.aws_availability_zones.availableAZ.names[*]]
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "id_private_subnets" {
  value = module.vpc.private_subnets[0]
}

output "id_bublic_subnets" {
  value = module.vpc.public_subnets[0]
} */

output "ip_public_bastion" {
  value = module.ec2-bastion.public_ip
}  

output "ip_private_bastion" {
  value = module.ec2-bastion.private_ip
} 

output "ip_public_frondends" {
  value = {
    for k, v in module.ec2-frondend : k => v.public_ip
  }

}

output "ip_private_backends" {
  value = {
    for k, v in module.ec2-backend : k => v.private_ip
  }

}