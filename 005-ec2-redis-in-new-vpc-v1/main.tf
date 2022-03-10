terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  required_version = ">= 0.14.9"
}

# Provider: https://registry.terraform.io/providers/hashicorp/aws/latest/docs
provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
  default_tags {
    tags = {
      project = basename(path.cwd)
    }
  }
}