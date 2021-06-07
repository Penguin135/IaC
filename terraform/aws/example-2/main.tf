resource "aws_key_pair" "ec2-test" { # ec2-test라는 이름의 aws_key_pair라는 타입의 리소스를 정의한다.
  key_name = "ec2-test" # 생성될 키페어의 이름
  public_key = file("~/.ssh/id_rsa.pub") # 키페어에 사용할 public key 지정
}

resource "aws_security_group" "ssh_mysql" {
  name = "allow_ssh_mysql_from_all"
  description = "Allow SSH Mysql port from all"
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
  }, {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "port 3306"
    from_port = 3306
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = "tcp"
    security_groups = []
    self = false
    to_port = 3306
  }, {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "port 80"
    from_port = 80
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = "tcp"
    security_groups = []
    self = false
    to_port = 80 
  }]

  egress = [ {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "outbound all"
    from_port = 0
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = "-1"
    security_groups = []
    self = false
    to_port = 0
  } ]

  tags = {
      Name = "ec2-test"
  }
}

resource "aws_instance" "web" {
  ami = "ami-0ba5cd124d7a79612" # ubuntu 18.04 이미지
  instance_type = "t2.micro" # 가상머신의 type 지정
  key_name = aws_key_pair.ec2-test.key_name # main.tf 에 정의되어 있는 'ec2-test' 키페어의 이름
  vpc_security_group_ids = [ # main.tf 에 정의되어 있는 security group의 id
    aws_security_group.ssh_mysql.id
  ]
}

resource "aws_db_instance" "ec2-test" {
  allocated_storage = 8
  engine = "mysql"
  engine_version = "5.7"
  instance_class = "db.t2.micro"
  username = "admin"
  password = "admin-password"
  skip_final_snapshot = true
  vpc_security_group_ids = [ # main.tf 에 정의되어 있는 security group의 id
    aws_security_group.ssh_mysql.id
  ]
}