#----------------------------------------------------
#        Variable params
#----------------------------------------------------
variable "region" {
    description = "AWS region for hosting our your network"
    default = "us-east-1"
}

variable "key_name" {
    description = "Key name for SSH into EC2"
    default = "ac_xl_pract_ssh"
}

variable "key_file" {
    description = "Key name for SSH into EC2"
    default = "~/Documents/.keys/ac_ups_terraform_202206.pem"
}
