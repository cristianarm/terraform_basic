terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.12.1"
    }
  }
  required_version = ">= 1.1.9"
}


provider "aws" {
  # Configuration options
  profile = "default"
  region  = "${var.prod_region}"

  default_tags {
    tags = {
      env            = "ac-aws",
      "cost:env"     = "academy-aws",
      "cost:project" = "ac-aws-pract"
    }
  }
}