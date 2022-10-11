
##################################################################################
# DATA
##################################################################################

data "aws_ssm_parameter" "ami" {
  name = var.aws_ami_name
}

data "aws_availability_zones" "available" {
  state = "available"
}

##################################################################################
# RESOURCES
##################################################################################

# NETWORKING #
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.16.0"
  cidr    = var.aws_vpc_cidr_block[terraform.workspace]

  azs            = slice(data.aws_availability_zones.available.names, 0, (var.vpc_subnets_count[terraform.workspace]))
  public_subnets = [for subnet in range(var.vpc_subnets_count[terraform.workspace]) : cidrsubnet(var.aws_vpc_cidr_block[terraform.workspace], 8, subnet)]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = merge(local.common_tags, {
    Name = "${local.naming_prefix}-vpc"
  })
}

# SECURITY GROUPS #
# Nginx security group 
resource "aws_security_group" "nginx-sg" {
  name   = var.aws_security_group_name
  vpc_id = module.vpc.vpc_id

  # HTTP access from anywhere
  ingress {
    from_port   = var.aws_security_inbound_from_port
    to_port     = var.aws_security_inbound_to_port
    protocol    = var.aws_security_inbound_protocol
    cidr_blocks = var.aws_subnet_cidr_block
  }

  # outbound internet access
  egress {
    from_port   = var.aws_security_outbound_from_port
    to_port     = var.aws_security_outbound_to_port
    protocol    = var.aws_security_outbound_protocol
    cidr_blocks = var.aws_security_group_outbound_ips
  }
  tags = merge(local.common_tags, {
    Name = "${local.naming_prefix}-nginx-sg"
  })
}

resource "aws_security_group" "nginx-sg-alb" {
  name   = var.aws_security_group_alb_name
  vpc_id = module.vpc.vpc_id

  # HTTP access from anywhere
  ingress {
    from_port   = var.aws_security_inbound_from_port
    to_port     = var.aws_security_inbound_to_port
    protocol    = var.aws_security_inbound_protocol
    cidr_blocks = var.aws_security_group_inbound_ips
  }

  # outbound internet access
  egress {
    from_port   = var.aws_security_outbound_from_port
    to_port     = var.aws_security_outbound_to_port
    protocol    = var.aws_security_outbound_protocol
    cidr_blocks = var.aws_security_group_outbound_ips
  }
  tags = merge(local.common_tags, {
    Name = "${local.naming_prefix}-nginx-sg-alb"
  })
}


