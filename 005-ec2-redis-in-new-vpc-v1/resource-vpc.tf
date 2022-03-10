# Resource-VPC: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
resource "aws_vpc" "dev_vpc" {
  ipv4_ipam_pool_id = aws_vpc_ipam_pool.dev_apn2_pool.id
  ipv4_netmask_length = 22
  depends_on = [
    aws_vpc_ipam_pool_cidr.dev_apn2_cidr
  ]
#  depends_on = [
#    aws_vpc_ipam_pool_cidr.dev_apn2_cidr_public_001, aws_vpc_ipam_pool_cidr.dev_apn2_cidr_public_002, aws_vpc_ipam_pool_cidr.dev_apn2_cidr_private_001, aws_vpc_ipam_pool_cidr.dev_apn2_cidr_private_002
#  ]
  tags = {
    Name = "dev_apn2_vpc_001"
  }
}

# Resource-Subnets: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
resource "aws_subnet" "dev_public_subnets_001" {
  vpc_id = aws_vpc.dev_vpc.id
  availability_zone = "ap-northeast-2a"
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "dev_public_subnets_001"
  }
}

resource "aws_subnet" "dev_public_subnets_002" {
  vpc_id = aws_vpc.dev_vpc.id
  availability_zone = "ap-northeast-2c"
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "dev_public_subnets_002"
  }
}

resource "aws_subnet" "dev_private_subnets_001" {
  vpc_id = aws_vpc.dev_vpc.id
  availability_zone = "ap-northeast-2a"
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "dev_private_subnets_001"
  }
}

resource "aws_subnet" "dev_private_subnets_002" {
  vpc_id = aws_vpc.dev_vpc.id
  availability_zone = "ap-northeast-2c"
  cidr_block = "10.0.3.0/24"
  tags = {
    Name = "dev_private_subnets_002"
  }
}

# Resource-IGW: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    Name = "dev_igw"
  }
}

# Resource-EIP: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
# Meta-Argument-lifecycle: https://www.terraform.io/language/meta-arguments/lifecycle
resource "aws_eip" "dev_ngw_eip_001" {
  vpc = true
  tags = {
    Name = "dev_ngw_eip_001"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_eip" "dev_ngw_eip_002" {
  vpc = true
  tags = {
    Name = "dev_ngw_eip_002"
  }
  lifecycle {
    create_before_destroy = true
  }
}

# Resource-NGW: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway
resource "aws_nat_gateway" "dev_ngw_001" {
  connectivity_type = "public"
  subnet_id = aws_subnet.dev_private_subnets_001.id
  allocation_id = aws_eip.dev_ngw_eip_001.id
  tags = {
    Name = "dev_ngw_az_a"
  }
}

resource "aws_nat_gateway" "dev_ngw_002" {
  connectivity_type = "public"
  subnet_id = aws_subnet.dev_private_subnets_002.id
  allocation_id = aws_eip.dev_ngw_eip_002.id
  tags = {
    Name = "dev_ngw_az_c"
  }
}

# Resource-defaultRouteTable: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table
resource "aws_default_route_table" "dev_public_rt" {
  default_route_table_id = aws_vpc.dev_vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_igw.id
  }
  tags = {
    Name = "default_dev_public_rt"
  }
}

resource "aws_route_table_association" "dev_public_rt_001" {
  subnet_id = aws_subnet.dev_public_subnets_001.id
  route_table_id = aws_default_route_table.dev_public_rt.id
}

resource "aws_route_table_association" "dev_public_rt_002" {
  subnet_id = aws_subnet.dev_public_subnets_002.id
  route_table_id = aws_default_route_table.dev_public_rt.id
}

# Resource-RouteTable: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "dev_private_rt_001" {
  vpc_id = aws_vpc.dev_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.dev_ngw_001.id
  }
  tags = {
    Name = "dev_private_rt_001"
  }
}

resource "aws_route_table_association" "dev_private_rt_001" {
  subnet_id = aws_subnet.dev_private_subnets_001.id
  route_table_id = aws_route_table.dev_private_rt_001.id
}

resource "aws_route_table" "dev_private_rt_002" {
  vpc_id = aws_vpc.dev_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.dev_ngw_002.id
  }
  tags = {
    Name = "dev_private_rt_002"
  }
}

resource "aws_route_table_association" "dev_private_rt_002" {
  subnet_id = aws_subnet.dev_private_subnets_002.id
  route_table_id = aws_route_table.dev_private_rt_002.id
}