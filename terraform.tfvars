billing_code = "ACCT8675309"
project      = "globo-web-app"

aws_vpc_cidr_block = {
  default     = "10.0.0.0/16"
  Development = "10.0.0.0/16"
  UAT         = "10.1.0.0/16" 
  Production  = "10.2.0.0/16"
}

vpc_subnets_count = {
  default     = 2
  default     = 2
  Development = 2
  UAT         = 2
  Production  = 3
}

instances_count = {
  default     = 2
  Development = 2
  UAT         = 4
  Production  = 6
}

target_group_count = {
  default     = 2
  Development = 2
  UAT         = 4
  Production  = 6
}

aws_instance_size = {
  default     = "t2.micro"
  Development = "t2.micro"
  UAT         = "t2.small"
  Production  = "t2.medium"
}
