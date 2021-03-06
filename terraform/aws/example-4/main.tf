resource "aws_lightsail_key_pair" "lightsail-test" { # lightsail-test라는 이름의 aws_lightsail_key_pair 라는 타입의 리소스를 정의한다.
  name = "lightsail-test" # 생성될 lightsail 키페어의 이름
  public_key = file("./id_rsa.pub") # 키페어에 사용할 public key 지정
}

# Create a new Lightsail Instance
resource "aws_lightsail_instance" "lightsail_test" {
  name              = "lightsail-test-instance"
  availability_zone = "ap-northeast-2a" # seoul regin 'a'
  blueprint_id      = "centos_7_2009_01"
  bundle_id         = "micro_2_0"
  key_pair_name     = aws_lightsail_key_pair.lightsail-test.name

  provisioner "local-exec" {
    command = <<EOF
      echo ${aws_lightsail_instance.lightsail_test.public_ip_address} ansible_ssh_user=centos ansible_ssh_private_key_file=~/.ssh/id_rsa >> inventory
    EOF
  }
}

resource "null_resource" "null-resource" {
  provisioner "local-exec" {
    command = <<EOF
        echo "[clients]" > inventory
    EOF
  }
}

resource "null_resource" "depend_ssh_keygen" {
  provisioner "local-exec" {
    command = <<EOF
      #sleep 60;
      #ssh-keyscan -H ${aws_lightsail_instance.lightsail_test.public_ip_address} >> ~/.ssh/known_hosts
      ANSIBLE_HOST_KEY_CHECKING=False \
      ansible-playbook -i inventory install_docker.yml
    EOF
  }
}
