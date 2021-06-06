data "aws_security_group" "default" {
  name = "default"
}

resource "aws_key_pair" "ec2-test" {
  key_name = "ec2-test"
  public_key = file("~/.ssh/.pub")
}

resource "aws_security_group" "ssh" {
  name = "allow_ssh_from_all"
  description = "Allow SSH port from all"
  ingress = [ {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "port 22"
    from_port = 22
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = "tcp"
    security_groups = []
    self = false
    to_port = 22
  } ]
  
}

resource "aws_instance" "web" {
  ami = "ami-0ba5cd124d7a79612" # ubuntu 18.04
  instance_type = "t2.micro"
  key_name = aws_key_pair.ec2-test.key_name
  vpc_security_group_ids = [
    aws_security_group.ssh.id,
    data.aws_security_group.default.id
  ]
}

resource "aws_db_instance" "ec2-test" {
  allocated_storage = 8
  engine = "mysql"
  engine_version = "5.6.35"
  instance_class = "db.t2.micro"
  username = "admin"
  password = "password"
  skip_final_snapshot = true
}
