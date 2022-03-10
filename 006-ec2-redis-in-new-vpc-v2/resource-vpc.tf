# Module: https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
module "dev_vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "dev-vpc"
  #cidr = aws_vpc_ipam_pool_cidr.dev_apn2_cidr.cidr
  cidr = "10.0.0.0/22"
  azs = ["${var.aws_region}a","${var.aws_region}c"]
  public_subnets = ["10.0.0.0/24","10.0.1.0/24"]
  private_subnets = ["10.0.2.0/24","10.0.3.0/24"]
  enable_nat_gateway = true
  one_nat_gateway_per_az = true

  public_subnet_suffix = "dev-public"
  private_subnet_suffix = "dev-private"

  vpc_tags = {
    Name = "dev_vpc"
  }

}

