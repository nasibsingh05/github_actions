data "aws_cloudfront_cache_policy" "CachingDisabled" {
  name = "Managed-CachingDisabled"
}


data "aws_vpc" "vpc" {
  id = var.vpc
}
