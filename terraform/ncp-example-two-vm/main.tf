provider "ncloud" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

# keypair create
#resource "ncloud_login_key" "loginkey"{
#  key_name = "webinar"
#}

data "template_file" "user_data" {
  template = templatefile("user-data.sh", {})
}

#server create
resource "ncloud_server" "server" {
  count = "2"
  #name = "tf-vm-${count.index+1}"
  name = format("tf-vm-%s", count.index+1)
  server_image_product_code = var.server_image_product_code
  server_product_code       = var.server_product_code

  login_key_name = "kkj-ncp"
  access_control_group_configuration_no_list = ["203098"]
  zone = var.ncloud_zones[count.index]
  user_data = data.template_file.user_data.rendered
}

# LB create
resource "ncloud_load_balancer" "lb" {

  name           = "my_lb"
  # 라운드 로빈 방식 사용
  algorithm_type = "RR"

  description    = "my_lb_description"

  rule_list {
      protocol_type   = "HTTP"
      load_balancer_port   = 80
      server_port          = 80
      l7_health_check_path = "/"
    }



  server_instance_no_list = [ncloud_server.server.*.id[0], ncloud_server.server.*.id[1]]
  internet_line_type = "PUBLC"
  network_usage_type = "PBLIP"
  region               = "KR"
}
