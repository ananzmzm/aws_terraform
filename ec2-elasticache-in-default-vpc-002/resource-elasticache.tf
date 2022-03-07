# Resources: subnet_group, security_group, Redis cluster

# Resource: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group
resource "aws_elasticache_subnet_group" "ec-subnets" {
  name       = "ec-subnets"
  subnet_ids = data.aws_subnets.redis_subnets.ids
}

# Resource: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_security_group
resource "aws_security_group" "ec-sg" {
  name = "RedisMemcached"
  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 11211
    to_port     = 11211
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

# Resource: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group#redis-cluster-mode-enabled
resource "aws_elasticache_replication_group" "redis-cluster" {
  description = var.ec_cluster_description
  replication_group_id          = var.ec_cluster_name
  node_type                   = var.ec_node_type
  automatic_failover_enabled = true
  subnet_group_name = aws_elasticache_subnet_group.ec-subnets.name
  security_group_ids = [aws_security_group.ec-sg.id]
  engine = "redis"
  engine_version = var.ec_engine_version

  num_node_groups = var.ec_number_of_shards
  replicas_per_node_group = var.ec_number_of_replicas_per_shard
}
