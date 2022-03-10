# Data Sources: VPC, Subnet, SG, Keypair
data "aws_vpc" "my_vpc" {
  default = true
}

data "aws_subnets" "redis_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.my_vpc.id]
  }
}

data "aws_key_pair" "my_key" {
  key_name = "key-kyoungy-seoul-002"
}