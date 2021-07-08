packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "packer-ansible-installed-ubuntu"
  instance_type = "t2.micro"
  region        = "ap-northeast-2"
  source_ami    = "ami-0ba5cd124d7a79612"
  ssh_username  = "ubuntu"
}


build {
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "shell" {
    environment_vars = [
      "FOO=hello world",
    ]
    inline = [
      "curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -",
      "sudo apt-add-repository \"deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb
_release -cs) main\"",
      "sudo apt-add-repository ppa:ansible/ansible",
      "sudo apt-get update -y && sudo apt-get install -y packer && sudo apt-get install -y
 ansible",
    ]
  }
}
