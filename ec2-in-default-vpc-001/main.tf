terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

resource "aws_instance" "basic" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    project = basename(path.cwd)
    Name = var.tag_case_id
  }
}