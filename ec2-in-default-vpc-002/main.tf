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

# Resources: EC2 Instance - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#example-usage
resource "aws_instance" "basic-001" {
  subnet_id = data.aws_subnets.my_subnets.ids[0]
  vpc_security_group_ids = [data.aws_security_group.ssh.id]
  key_name      = data.aws_key_pair.my_key.key_name

  ami           = var.ami_id
  instance_type = var.instance_type
  count = var.instance_count
  associate_public_ip_address = var.public_ip

  tags = {
    project = basename(path.cwd)
    Name = var.tag_case_id
  }
}
