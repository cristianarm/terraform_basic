variable "region" {
  description = "AWS region for hosting our your network"
  #default = "us-east-1"
}
variable "namespace" {
  type        = string
  description = "Namespace, which could be your organization name, e.g. 'eg' or 'cp'"
}

variable "stage" {
  type        = string
  description = "Stage, e.g. 'prod', 'staging', 'dev' or 'testing'"
}

variable "avzone" {
  description = "AWS region for hosting our your network"
  default     = "us-east-1d"
}

variable "instance_type" {
  description = ""
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key name for SSH into EC2"
  default     = "cristian.rm_key_ed"
}
#----------------------------------------------------
#        Variable Networking
#----------------------------------------------------
variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.10.10.0/24"
}

variable "cidr_internet" {
  default = "0.0.0.0/0"
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = false
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}