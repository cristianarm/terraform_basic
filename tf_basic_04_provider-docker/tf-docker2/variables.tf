# Input Variable
# Name environment
variable "env" {
  description = "environment: dev or prod"
}

# local variables
variable "version_image" {
    type = string
    default = "nginx:1.21-alpine"
}

variable "container_name" {
  type        = map
  description = "Name of the container."
  default     = {
    dev  = "d_docker_dev"
    prod = "d_docker_prod"
  }
}

variable "int_port" {
  description = "Internal port for container."
  default     = "80"
}
variable "ext_port" {
  type        = map
  description = "External port for container."
  default     = {
    dev  = "8000"
    prod = "8081"
  }
}