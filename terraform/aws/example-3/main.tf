resource "aws_lightsail_key_pair" "lightsail-test" { # lightsail-test라는 이름의 aws_lightsail_key_pair 라는 타입의 리소스를 정의
  name = "lightsail-test" # 생성될 lightsail 키페어의 이름
  public_key = file("./lightsail_key.pub") # 키페어에 사용할 public key 지정
}

# Create a new Lightsail Instance
resource "aws_lightsail_instance" "lightsail_test" {
  name              = "lightsail-test-instance"
  availability_zone = "ap-northeast-2a" # seoul regin 'a'
  blueprint_id      = "ubuntu_18_04"
  bundle_id         = "micro_2_0"
  key_pair_name     = aws_lightsail_key_pair.lightsail-test.name
  tags = {
    Name = "my-lightsail"
  }
}

resource "aws_lightsail_instance_public_ports" "lightsail_firewall_test" { # lightsail_firewall_test 라는 이름의 aws_lightsail_instance_public_ports 라는 타입의 리소스 정의
    instance_name = aws_lightsail_instance.lightsail_test.name # 적용할 lightsail instance의 이름

    # port information
    port_info {
            protocol = "tcp"
            from_port = 80
            to_port = 0
    } 
    port_info {
            protocol = "tcp"
            from_port = 22
            to_port = 0
    }
    port_info {
            protocol = "tcp"
            from_port = 3306
            to_port = 0
    }
}