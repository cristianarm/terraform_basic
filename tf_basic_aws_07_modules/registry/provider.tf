# Defining the Provider of the Terraform
# provider to download
terraform {
  #required_version = ">= 1.0.6"
  required_version = ">= 1.2.3"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.20.1"
    }
  }
}


provider "aws" {
  # Configuration options
  profile = "default"
  region  = "${var.region}"

  default_tags {
    tags = {
      env = "ac-tr-202206",
      "cost:env" = "academy",
      "cost:project" = "ac-us-terraform-202206"
      Owner = "cristian.rm"
    }
  }
}
