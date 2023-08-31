# provider
terraform {
  required_providers {
    tencentcloud = {
      source  = "tencentcloudstack/tencentcloud"
    }
  }
}

# cos
resource "tencentcloud_cos_bucket" "cdn_backend_cos" {
  bucket            = "${var.cos_bucket_name}-${var.appid}"
  acl               = "private"
}

# cos policy for cdn
resource "tencentcloud_cos_bucket_policy" "cdn_cos_policy" {
  bucket = tencentcloud_cos_bucket.cdn_backend_cos.bucket
  policy = <<EOF
{
  "Statement": [
    {
      "Action": [
        "name/cos:GetObject",
        "name/cos:HeadObject",
        "name/cos:OptionsObject"
      ],
      "Effect": "Allow",
      "Principal": {
        "qcs": [
          "qcs::cam::uin/${var.root_uid}:service/cdn"
        ]
      },
      "Resource": [
        "qcs::cos:${var.region}:uid/${var.appid}:${var.cos_bucket_name}-${var.appid}/*"
      ]
    }
  ],
  "version": "2.0"
}
EOF
}

# cdn
resource "tencentcloud_cdn_domain" "cdn" {
  domain       = "${var.cdn_subdomain}.${var.cdn_domain}"
  service_type = var.cdn_service_type
  area         = var.cdn_area

  origin {
    origin_type          = "cos"
    origin_list          = [tencentcloud_cos_bucket.cdn_backend_cos.cos_bucket_url]
    server_name          = tencentcloud_cos_bucket.cdn_backend_cos.cos_bucket_url
    origin_pull_protocol = "http"
    cos_private_access   = "on"
  }
}

# cdn dns record
resource "tencentcloud_dnspod_record" "cdn_record" {
    domain      = var.cdn_domain
    record_type = "CNAME"
    record_line = "默认"
    value       = "${tencentcloud_cdn_domain.cdn.cname}."
    sub_domain  = var.cdn_subdomain
}

