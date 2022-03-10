# Variable declarations
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-2"
}

variable "aws_profile" {
  description = "AWS profile"
  type = string
  default = "terraform"
}

variable "instance_count" {
  description = "Number of instances to provision."
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "AWS EC2 instance type."
  type        = string
  default = "t3.micro"
}

variable "ami_id" {
  description = "AWS Image for EC2 instance"
  type = string
  default = "ami-0029dbeb91e3b0f5f" # Amazon Linux 2 AMI (HVM) - Kernel 5.10
}

variable "public_ip" {
  description = "associate public ip address when launching"
  type = bool
  default = true
}

variable "tag_case_id" {
  description = "Give me your case-id as an instance Name"
  type = string
}