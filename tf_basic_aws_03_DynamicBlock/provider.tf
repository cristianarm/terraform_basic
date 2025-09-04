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
  region  = var.region

  default_tags {
    tags = {
      Name        = "terraform_learn"
      "cost:env" = "basic"
      "cost:project" = "tf_basic_aws"
    }
  }
}
