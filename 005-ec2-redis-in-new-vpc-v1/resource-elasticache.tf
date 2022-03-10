# Resources: subnet_group, security_group, Redis cluster

# Resource: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group
resource "aws_elasticache_subnet_group" "ec-subnets" {
  name       = "ec-subnets"
  subnet_ids = [aws_subnet.dev_private_subnets_001.id, aws_subnet.dev_private_subnets_002.id]
}

# Resource: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_security_group
resource "aws_security_group" "ec-sg" {
  name = "RedisMemcached"
  vpc_id = aws_vpc.dev_vpc.id
  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#resource "aws_elasticache_security_group" "ec-sg" {
#  name                 = "elasticache_sg"
#  security_group_names = [aws_security_group.ec-sg.name]
#}

# Resource: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group
resource "aws_elasticache_replication_group" "dev-redis-cluster" {
  description = var.ec_cluster_description
  replication_group_id          = var.ec_cluster_name
  node_type                   = var.ec_node_type
  num_cache_clusters       = var.ec_number_of_nodes
  automatic_failover_enabled = true
  subnet_group_name = aws_elasticache_subnet_group.ec-subnets.name
  security_group_ids = [aws_security_group.ec-sg.id]
  engine = "redis"
  engine_version = var.ec_engine_version
}