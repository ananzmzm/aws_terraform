# Resources: subnet_group, security_group, Redis cluster

# Resource: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group
resource "aws_elasticache_subnet_group" "ec-subnets" {
  name       = "ec-subnets"
  subnet_ids = module.dev_vpc.private_subnets
}

# Module: https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest/submodules/redis
module "dev_ec_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name = "dev-redis-sg"
  vpc_id = module.dev_vpc.vpc_id
  ingress_with_source_security_group_id = [
    {
      from_port   = 6379
      to_port     = 6379
      protocol    = "tcp"
      description = "Redis ports"
      source_security_group_id = aws_security_group.dev_ssh_sg.id
    },
  ]
}

# Resource: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group
resource "aws_elasticache_replication_group" "dev-redis-cluster" {
  description = var.ec_cluster_description
  replication_group_id          = var.ec_cluster_name
  node_type                   = var.ec_node_type
  num_cache_clusters       = var.ec_number_of_nodes
  automatic_failover_enabled = true
  subnet_group_name = aws_elasticache_subnet_group.ec-subnets.name
  security_group_ids = [module.dev_ec_sg.security_group_id]
  engine = "redis"
  engine_version = var.ec_engine_version
}