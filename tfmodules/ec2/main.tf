provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "web" {
  ami = "${data.aws_ami.myami.id}"
  instance_type = "t2.micro"
  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.demo.id}"]
  tags = {
    Name = "${var.env}-${var.nombre}"
  }
}

resource "aws_security_group" "demo" {
 name        = "${var.env}_sg_hello"
 description = "Allow http inbound traffic"

 ingress {
   from_port   = 22
   to_port     = 22
   protocol    = "tcp"
   cidr_blocks     = ["0.0.0.0/0"]
 }
 ingress {
   from_port   = 80
   to_port     = 80
   protocol    = "tcp"
   cidr_blocks     = ["0.0.0.0/0"]
 }

 egress {
   from_port       = 0
   to_port         = 0
   protocol        = "-1"
   cidr_blocks     = ["0.0.0.0/0"]
 }
}
