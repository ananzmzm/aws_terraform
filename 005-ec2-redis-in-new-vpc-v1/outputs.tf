output "instance_id" {
  description = "ID of the EC2 instance"
  value = aws_instance.bastion-redis-client.*.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value = aws_instance.bastion-redis-client.*.public_ip
}

output "key_pair" {
  value = aws_instance.bastion-redis-client.*.key_name
}

output "elasticache" {
  value = aws_elasticache_replication_group.dev-redis-cluster.*.primary_endpoint_address
}