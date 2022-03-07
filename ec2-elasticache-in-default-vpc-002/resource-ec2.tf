# Resource: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#example-usage
resource "aws_instance" "redis-client" {
  subnet_id = data.aws_subnets.ec2_subnets.ids[0]
  vpc_security_group_ids = [data.aws_security_group.ssh.id]
  key_name      = data.aws_key_pair.my_key.key_name

  ami           = var.ami_id
  instance_type = var.instance_type
  count = var.instance_count
  associate_public_ip_address = var.public_ip

  tags = {
    #project = basename(path.cwd)
    Name = var.tag_case_id
  }
}