variable "region" {
    description = "this is the region where the resources will be deployed"
    default = "us-east-1"
}
variable "environment" {
    default = "test" 
}

variable "project" {
    description = "this is the project name"
    default = "lab-courier"
}

variable "cidr_vpc" {
  description = "range ip to vpc"
  default = "18.0.0.0/16"
}


variable "subneta_name" {
    description = "this is the subnet A -name tag"
    default = "lab-courier-subnet-a"
}
variable "subnetb_name" {
    description = "this is the subnet B -name tag"
    default = "lab-courier-subnet-b"

}

variable "vpc_name" {
    description = "Name of vpc"
    default = "VPC-lab-courier"
  
}
