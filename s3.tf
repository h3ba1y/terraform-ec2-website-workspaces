module "web_app_s3" {
  source                  = "./modules/globo_web_app_s3"
  bucket_name             = local.s3_bucket_name
  elb_service_account_arn = data.aws_elb_service_account.root.arn
  common_tags             = local.common_tags
}
resource "aws_s3_object" "website_content" {
  for_each = {
    logo    = "/website/Globo_logo_Vert.png"
    website = "/website/index.html"
  }
  bucket = module.web_app_s3.web_bucket.bucket
  key    = each.value
  source = ".${each.value}"
  tags = merge(local.common_tags, {
    Name = "${local.naming_prefix}-website-content"
  })
}
