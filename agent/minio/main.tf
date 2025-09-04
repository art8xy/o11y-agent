locals {
  context = "${path.module}/context"
}

resource "minio_s3_bucket" "context" {
  bucket        = "context"
  acl           = "public"
  force_destroy = true
}

resource "minio_s3_object" "context" {
  for_each = fileset(local.context, "**/*.md")

  bucket_name = minio_s3_bucket.context.bucket
  object_name = each.value

  content_type = "text/markdown"
  source       = "${local.context}/${each.value}"
}