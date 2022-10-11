# INSTANCES #
resource "aws_instance" "nginxs" {
  count                  = var.instances_count[terraform.workspace]
  ami                    = nonsensitive(data.aws_ssm_parameter.ami.value)
  instance_type          = var.aws_instance_size[terraform.workspace]
  subnet_id              = module.vpc.public_subnets[(count.index % var.vpc_subnets_count[terraform.workspace])]
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]
  iam_instance_profile   = module.web_app_s3.instance_profile.name
  depends_on             = [module.web_app_s3]
  tags = merge(local.common_tags, {
    Name = "${local.naming_prefix}-instance"
  })
  user_data = templatefile("${path.module}/startup_script.tpl", {
    s3_bucket_name = module.web_app_s3.web_bucket.id
  })
}
