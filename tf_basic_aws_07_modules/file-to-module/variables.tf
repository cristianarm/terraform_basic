variable "region" {
    default = "us-east-1"
}

variable "namespace" {
    type        = string
    description = "Namespace, which could be your organization name, e.g. 'eg' or 'cp'"
}

variable "stage" {
    type        = string
    description = "Stage, e.g. 'prod', 'staging', 'dev' or 'testing'"
}

variable "key_name" {
    description = "Key name for SSH into EC2"
    default = "ac_ups_terraform_202206"
}