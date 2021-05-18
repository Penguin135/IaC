variable "access_key" { # export TF_VAR_access_key=...
}

variable "secret_key" { # export TF_VAR_secret_key=...
}

variable "ncloud_zones" {
  default = ["KR-1", "KR-2"]
}

variable "region" {
  default = "KR"
}

variable "server_name" {
  default = "terraform-test"
}

variable "server_image_product_code" {
  default = "SPSW0LINUX000046"
}

variable "server_product_code" {
  default = "SPSVRSSD00000002" #SPSVRSTAND000056
}
