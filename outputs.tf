output "tcc_cos_bucket_url" {
    value = tencentcloud_cos_bucket.cdn_backend_cos.cos_bucket_url
}

output "tcc_cdn_domain" {
    value = tencentcloud_cdn_domain.cdn.domain
}

output "tcc_cdn_cname" {
    value = tencentcloud_cdn_domain.cdn.cname
}
