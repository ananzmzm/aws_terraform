# Data Sources: VPC, Subnet, SG, Keypair
data "aws_vpc" "my_vpc" {
  default = true
}

data "aws_subnets" "my_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.my_vpc.id]
  }
  filter {
    name   = "tag:Name"
    values = ["*az1*"]
  }
}

data "aws_security_group" "ssh" {
  filter {
    name   = "group-name"
    values = ["*SSH*"]
  }
}

data "aws_key_pair" "my_key" {
  key_name = "key-kyoungy-seoul-002"
}