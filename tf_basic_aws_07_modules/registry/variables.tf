variable "region" {
    default = "us-east-1"
}

variable "namespace" {
    type        = string
    description = "Namespace, which could be your organization name, e.g. 'eg' or 'cp'"
    default = "cp"
}

variable "stage" {
    type        = string
    description = "Stage, e.g. 'prod', 'staging', 'dev' or 'testing'"
    default = "testing"
}

variable "key_name" {
    description = "Key name for SSH into EC2"
    default = "cristian.rm_key_ed"
}


variable "cidr" {
  default = "10.80.0.0/16"
}

variable "cidr_internet" {
  default = "0.0.0.0/0"
}