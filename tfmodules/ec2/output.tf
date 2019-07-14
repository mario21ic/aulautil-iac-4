output "ip" {
  value = "${aws_instance.web.public_ip}"
}

output "ids" {
  value = "${aws_instance.web.id}"
}

output "sg_id" {
  value = "${aws_security_group.demo.id}"
}

