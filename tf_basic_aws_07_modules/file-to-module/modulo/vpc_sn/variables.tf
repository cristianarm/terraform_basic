variable "namespace" {
    type        = string
    description = "Namespace, which could be your organization name, e.g. 'eg' or 'cp'"
    default = "cp"
}

variable "stage" {
    type        = string
    description = "Stage, e.g. 'prod', 'staging', 'dev' or 'testing'"
    default = "stg"
}
#----------------------------------------------------
#        Variable Networking
#----------------------------------------------------
variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.10.0.0/16"
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