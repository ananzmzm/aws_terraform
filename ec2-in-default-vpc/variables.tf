# Variable declarations
variable "aws_profile" {
  description = "AWS Profile"
  type = string
  default = "terraform"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-2"
}

variable "ami_id" {
  description = "AWS Image for EC2 instance"
  type = string
  default = "ami-0029dbeb91e3b0f5f" # Amazon Linux 2 AMI (HVM) - Kernel 5.10
}

variable "instance_type" {
  description = "AWS EC2 instance type."
  type        = string
  default = "t3.micro"
}

variable "tag_case_id" {
  description = "Case-id as an instance name"
  type = string
}