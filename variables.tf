variable "aws_region" {
  type        = string
  description = "AWS region for all the resources"
  default     = "us-east-1"
}

variable "aws_instance_size" {
  type        = map(string)
  description = "AWS EC2 instance size"
}

variable "aws_ami_name" {
  type        = string
  description = "AWS AMI name"
  default     = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

variable "aws_vpc_cidr_block" {
  type        = map(string)
  description = "AWS VPC cidr block"
}

variable "aws_vpc_dns_enabled" {
  type        = bool
  description = "AWS VPC cidr e"
  default     = true
}

variable "aws_subnet_cidr_block" {
  type        = list(string)
  description = "AWS subnet cidr block"
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "aws_subnet1_ip_enabled" {
  type        = bool
  description = "AWS subnet 1 ip enabled"
  default     = true
}

variable "aws_security_group_name" {
  type        = string
  description = "AWS security group name"
  default     = "nginx_sg"
}

variable "aws_security_group_alb_name" {
  type        = string
  description = "AWS security group name"
  default     = "nginx_sg_alb"
}

variable "aws_security_inbound_protocol" {
  type        = string
  description = "AWS security group inbound protocol"
  default     = "tcp"
}

variable "aws_security_inbound_from_port" {
  type        = number
  description = "AWS security group inbound protocol"
  default     = 80
}

variable "aws_security_inbound_to_port" {
  type        = number
  description = "AWS security group inbound protocol"
  default     = 80
}

variable "aws_security_group_inbound_ips" {
  type        = list(string)
  description = "AWS security group inbound allowed ips"
  default     = ["0.0.0.0/0"]
}

variable "aws_security_outbound_protocol" {
  type        = string
  description = "AWS security group inbound protocol"
  default     = "-1"
}

variable "aws_security_group_outbound_ips" {
  type        = list(string)
  description = "AWS security group inbound allowed ips"
  default     = ["0.0.0.0/0"]
}

variable "aws_security_outbound_from_port" {
  type        = number
  description = "AWS security group inbound protocol"
  default     = 0
}

variable "aws_security_outbound_to_port" {
  type        = number
  description = "AWS security group inbound protocol"
  default     = 0
}



variable "company" {
  type        = string
  description = "company tag"
  default     = "Globalmantics"
}

variable "project" {
  type        = string
  description = "prohect tag"
}

variable "billing_code" {
  type        = string
  description = "billing code tag"
}

variable "vpc_subnets_count" {
  type        = map(number)
  description = "this is the vpc subnets count"
}

variable "instances_count" {
  type        = map(number)
  description = "this is the instances count"
}

variable "target_group_count" {
  type        = map(number)
  description = "this is the target group count"
}

variable "naming_prefix" {
  type        = string
  default     = "globoweb"
  description = "naming prefix for all resources"
}