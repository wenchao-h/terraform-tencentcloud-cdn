# tcc-cdn-cos-dns
## usage
terraform file
```
module "cdn" {
  source = "wenchao-h/cdn/tencentcloud"

  region = var.region
  root_uid = var.root_uid
  appid = var.appid
  cos_bucket_name = "sg-overseas-web-cos"
  cdn_domain = "example.com"
  cdn_subdomain = "web"
  cdn_service_type = "web"
  cdn_area = "overseas"
}

output "tc_sg_web_cos_bucket_url" {
    value = module.cdn.tcc_cos_bucket_url
}

output "cdn_domain" {
    value = module.cdn.tcc_cdn_domain
}

output "cdn_cname" {
    value = module.cdn.tcc_cdn_cname
}
```

need to export env parameters before applying
```
export TF_VAR_tcc_secret_id=xxx TF_VAR_tcc_secret_key=xxx TF_VAR_region=ap-xx TF_VAR_root_uid=xx TF_VAR_appid=xx
```
