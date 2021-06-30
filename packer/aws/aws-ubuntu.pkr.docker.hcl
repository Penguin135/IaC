source "amazon-ebs" "ubuntu" {
  ami_name      = "learn-packer-linux-aws"
  instance_type = "t2.micro"
  region        = "ap-northeast-2"
  source_ami    = "ami-04876f29fd3a5e8ba"
  ssh_username = "ubuntu"
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
      "curl -fsSL https://test.docker.com -o test-docker.sh",
      "sudo sh test-docker.sh",
      "sudo usermod -aG docker ubuntu",
      "echo \"FOO is $FOO\" > example.txt",
    ]
  }
}
