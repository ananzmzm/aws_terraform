# Variable declarations
# Security Group
variable "sg_prefix_id" {
  description = "prefix for Amazon CORP and Prod(ICN only)"
  type = string
  default = "pl-75a7421c"
}
# EC2 instance
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
  default = "ami-004844cf23eb834f9" # Redis 6 client on Amazon Linux 2 AMI (HVM) - Kernel 5.10
}

variable "public_ip" {
  description = "associate public ip address when launching"
  type = bool
  default = true
}

variable "tag_case_id" {
  description = "Give me your case-id as an instance Name"
  type = string
  default = "kyoungy-tf"
}