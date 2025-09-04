output "timestamp" {
  value = local.time
}

output "ami-id" {
  description = "ami segun region"
  value = lookup(var.ami,var.region)
}

output "show_region" {
  description = "region in AWS"
  value = var.region
}

output "range_vpc" {
  value = var.icdr
}

output "rango_icdr_4" {
  value = cidrsubnet(var.icdr, 4, 2)
}

output "rango_icdr_8" {
  value = cidrsubnet(var.icdr, 8, 3)
}

output "range_subnets" {
  value = cidrsubnets(var.icdr, 8, 8, 8, 4)
}

output "multi_sub" {
  value =  [for cidr_block in cidrsubnets(var.icdr, 8, 8, 8, 8) : cidrsubnets(cidr_block, 4, 4)]
}