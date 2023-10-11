terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # This code was tested on aws module 5.20.1
    }
  }
  required_version = ">= 1.5.7" # This code was tested on terraform version 1.5.7
}

data "aws_region" "current" {}

provider "aws" {
  default_tags {
    tags = {
      Resource = var.bucket_name
    }
  }

  region = "us-east-1"
}
