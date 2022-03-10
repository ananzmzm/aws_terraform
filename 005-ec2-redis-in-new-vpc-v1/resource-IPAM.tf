# Step 1. Create an IPAM
# Resource: https://registry.terraform.io/providers/hashicorp%20%20/aws/latest/docs/resources/vpc_ipam
resource "aws_vpc_ipam" "my_ipam" {
  description = "IPAM by terraform"
  dynamic "operating_regions" {
    for_each = var.ipam_regions
    content {
      region_name = operating_regions.value
    }
  }
}

# Step 2. Create a top-level pool
# Resource: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_pool
resource "aws_vpc_ipam_pool" "top_level_pool" {
  description = "top level pool by terraform"
  address_family = "ipv4"
  ipam_scope_id  = aws_vpc_ipam.my_ipam.private_default_scope_id
}

# Resource: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_pool_cidr
resource "aws_vpc_ipam_pool_cidr" "top_level_cidr" {
  ipam_pool_id = aws_vpc_ipam_pool.top_level_pool.id
  cidr = "10.0.0.0/16"
}

# Step 3. Create a Regional pool
resource "aws_vpc_ipam_pool" "apn2_pool" {
  description = "regional pool: ap_northeast_2"
  address_family = "ipv4"
  ipam_scope_id  = aws_vpc_ipam.my_ipam.private_default_scope_id
  locale = "ap-northeast-2"
  source_ipam_pool_id = aws_vpc_ipam_pool.top_level_pool.id
}

resource "aws_vpc_ipam_pool_cidr" "apn2_cidr" {
  ipam_pool_id = aws_vpc_ipam_pool.apn2_pool.id
  cidr = "10.0.0.0/20"
}

# Step 4. Create a development pool
resource "aws_vpc_ipam_pool" "dev_apn2_pool" {
  description = "development pool under apn2 pool"
  address_family = "ipv4"
  ipam_scope_id  = aws_vpc_ipam.my_ipam.private_default_scope_id
  locale = "ap-northeast-2"
  source_ipam_pool_id = aws_vpc_ipam_pool.apn2_pool.id
}

resource "aws_vpc_ipam_pool_cidr" "dev_apn2_cidr" {
  ipam_pool_id = aws_vpc_ipam_pool.dev_apn2_pool.id
  cidr = "10.0.0.0/22"
}

#resource "aws_vpc_ipam_pool_cidr" "dev_apn2_cidr_public_001" {
#  ipam_pool_id = aws_vpc_ipam_pool.dev_apn2_pool.id
#  cidr = "10.0.0.0/24"
#}
#
#resource "aws_vpc_ipam_pool_cidr" "dev_apn2_cidr_public_002" {
#  ipam_pool_id = aws_vpc_ipam_pool.dev_apn2_pool.id
#  cidr = "10.0.1.0/24"
#}
#
#resource "aws_vpc_ipam_pool_cidr" "dev_apn2_cidr_private_001" {
#  ipam_pool_id = aws_vpc_ipam_pool.dev_apn2_pool.id
#  cidr = "10.0.2.0/24"
#}
#
#resource "aws_vpc_ipam_pool_cidr" "dev_apn2_cidr_private_002" {
#  ipam_pool_id = aws_vpc_ipam_pool.dev_apn2_pool.id
#  cidr = "10.0.3.0/24"
#}