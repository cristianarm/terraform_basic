terraform {
  required_version = ">= 1.1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      # https://registry.terraform.io/providers/hashicorp/aws/latest
      version = "3.72.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = var.region

  default_tags {
    tags = {
      env            = "ac-aws",
      "cost:env"     = "academy-aws",
      "cost:project" = "ac-aws-jun"
    }
  }
}
