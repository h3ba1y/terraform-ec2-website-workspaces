resource "random_integer" "rand" {
  min = 10000
  max = 99999
}

locals {
  common_tags = {
    company      = var.company
    project      = "${var.company} - ${var.project}"
    billing_code = var.billing_code
    environment  = terraform.workspace
  }
  s3_bucket_name = "${local.naming_prefix}-${terraform.workspace}-${random_integer.rand.result}"
  naming_prefix  = "${var.naming_prefix}-${terraform.workspace}"
}


