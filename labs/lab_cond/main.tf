
variable "s3_buckets" {
  type = map(bool)
  default = {
    "prod" = true
    "dev"  = false
  }
}


resource "aws_s3_bucket" "buckets" {
  for_each = { for k, v in var.s3_buckets : k => v if v }

  bucket = "my-app-${each.key}"
  acl    = "private"

  tags = {
    Name        = "Bucket for ${each.key}"
    Environment = each.key
  }
}

