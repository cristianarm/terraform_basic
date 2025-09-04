variable "type_instance" {
  description = "tipo de intance a seleccionar"
  type = string
  default = "t2.micro"
}


variable "ami_instance" {
  description = "tipo de ami para la intance"
  type = string
  default = "Amazon Linux"
}

variable "ip_list" {
    description = "lista de ip"
    type = list
    default = [
        "10.130.2.5/32",
        "10.130.2.6/32"
    ]
}

variable "name_instance" {
  description = "tipo de ami para la intance"
  type = string
}