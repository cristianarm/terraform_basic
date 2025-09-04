variable "dev" {}
variable "env" {}
variable "project" {}
variable "subneta" {}
variable "subnetb" {}
variable "vpc_id" {}
variable "sg-project" {}
variable "td_port" {}
variable "subnets" {
  description = "list of subnets"
  type = list
}