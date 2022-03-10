# Resource: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "dev_ssh_sg" {
  name = "dev_ssh_sg"
  vpc_id = module.dev_vpc.vpc_id
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

# Module: https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest
# Example: https://github.com/terraform-aws-modules/terraform-aws-ec2-instance/blob/master/examples/complete/main.tf
module "dev_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"
  for_each = toset(["001","002","003"])
  name = "${var.instance_name}-${each.key}"
  ami = var.ami_id
  instance_type = var.instance_type
  key_name = data.aws_key_pair.my_key.key_name
  monitoring = true
  vpc_security_group_ids = [aws_security_group.dev_ssh_sg.id]
  subnet_id = element(module.dev_vpc.public_subnets, 0)
  associate_public_ip_address = true

}