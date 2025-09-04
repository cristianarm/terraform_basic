#----------------------------------------------------
#        Variable params
#----------------------------------------------------
variable "region" {
    description = "AWS region for hosting our your network"
    default = "us-east-1"
}

variable "key_name" {
    description = "Key name for SSH into EC2"
    default = "key-ssh-academy-aws"
}

variable "tags" {
  type = list
  default = ["first-ec2","seconde-c2","third-c2"]
}

variable "ami" {
  type = map
  default = {
    "us-east-1" = "ami-0323c3dd2da7fb37d"
    "us-west-2" = "ami-0d6621c01e8c2de2c"
    "ap-south-1" = "ami-0470e33cd681b2476"
  }
}

variable "icdr" {
  description = "muestra el rango de la vpc"
  type = string
  default = "10.130.0.0/16"
}
