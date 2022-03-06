output "instance_id" {
  description = "ID of the EC2 instance"
  value = aws_instance.basic-001.*.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value = aws_instance.basic-001.*.public_ip
}

output "key_pair" {
  value = aws_instance.basic-001.*.key_name
}