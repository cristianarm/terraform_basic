variable "project" {}
variable "vpc_id" {}
variable "env" {
    description = "this is the environment to deploy our infrastructure"
}

variable "cidr_internet" {
  description = "renge ip to internet"
  default = "0.0.0.0/0"
}

variable "port_http" {
    default = 80
}

variable "port_https" {
    default = 443
}