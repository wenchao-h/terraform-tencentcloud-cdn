# region
variable "region" {
    type = string
}

# root account uid
variable "root_uid" {
    type = string
}

# account appid
variable "appid" {
    type = string
}

# cos bucket name, not include appid
variable "cos_bucket_name" {
    type = string
}

# cdn domain
variable "cdn_domain" {
    type = string
}

# cdn subdomain
variable "cdn_subdomain" {
    type = string
}

# cdn service_type, service type. `web`: static acceleration, `download`: download acceleration, `media`: streaming media VOD acceleration, `hybrid`: hybrid acceleration, `dynamic`: dynamic acceleration.
variable "cdn_service_type" {
    type = string
    validation {
        condition  = contains(["web", "download", "media", "hybrid", "dynamic"], var.cdn_service_type)
        error_message = "Allowed values for cdn_service_type are \"web\", \"download\", \"media\", \"hybrid\", \"dynamic\"."
    }
}

# cdn area
variable "cdn_area" {
    type = string
    validation {
        condition = contains(["mainland", "overseas", "global"], var.cdn_area)
        error_message = "Allowed values for cdn_area are \"mainland\", \"overseas\", \"global\"."
    }
}