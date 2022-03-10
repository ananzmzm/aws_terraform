# Resource: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "dev_ssh_sg" {
  name = "dev_ssh_sg"
  vpc_id = aws_vpc.dev_vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    prefix_list_ids = [var.sg_prefix_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Resource: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#example-usage
resource "aws_instance" "bastion-redis-client" {
  subnet_id = aws_subnet.dev_public_subnets_001.id
  vpc_security_group_ids = [aws_security_group.dev_ssh_sg.id]
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