data "aws_elb_service_account" "root" {}

resource "aws_lb" "nginx" {
  name               = "globo-web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.nginx-sg-alb.id]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = false

  access_logs {
    bucket  = module.web_app_s3.web_bucket.id
    prefix  = "alb-logs"
    enabled = true
  }

  tags = merge(local.common_tags, {
    Name = "${local.naming_prefix}-alb"
  })
}

resource "aws_lb_target_group" "nginx" {
  name     = "nginx-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  tags = merge(local.common_tags, {
    Name = "${local.naming_prefix}-alb-tartget-group"
  })
}

resource "aws_lb_listener" "nginx" {
  load_balancer_arn = aws_lb.nginx.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx.arn
  }

  tags = merge(local.common_tags, {
    Name = "${local.naming_prefix}-alb-listener"
  })
}

resource "aws_lb_target_group_attachment" "nginxs" {
  count            = var.target_group_count[terraform.workspace]
  target_group_arn = aws_lb_target_group.nginx.arn
  target_id        = aws_instance.nginxs[count.index].id
  port             = 80
}