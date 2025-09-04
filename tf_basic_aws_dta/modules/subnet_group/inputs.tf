variable "project" {}
variable "env" {}
variable "subneta" {}
variable "subnetb" {}
variable "subnets" {
  description = "list of subnets"
  type = list
}