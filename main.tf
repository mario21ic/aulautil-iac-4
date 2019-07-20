provider "aws" {
  region = "${var.region}"
}
provider "consul" {
  address    = "http://localhost:8500"
  datacenter = "dc1"
}

terraform {
  backend "s3" {
    bucket = "mario21ic.terraform.state"
    key = "infrav1/terraform.tfstate"
    region = "us-west-2"
  }
  required_version = ">0.9.4"
}

variable "region" {
}

output "ip" {
  value = "${module.web.ip}"
}

output "sg_id" {
  value = "${module.web.sg_id}"
}

output "web_sg_id" {
  value = "${data.consul_keys.read_web_sg_id.var.web_sg_id}"
}

module "web" {
  source = "./tfmodules/ec2/"

  region = "${var.region}"
  env = "${terraform.workspace}"
  ami_name = "mynginx"
  key_name = "demokp"
  nombre = "demo"
}

resource "aws_elb" "demo" {
 name               = "${terraform.workspace}-demo"
 availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]

 listener {
   instance_port     = 80
   instance_protocol = "http"
   lb_port           = 80
   lb_protocol       = "http"
 }

 health_check {
   healthy_threshold   = 10
   unhealthy_threshold = 6
   timeout             = 10
   target              = "HTTP:80/"
   interval            = 30
 }

 instances                   = ["${module.web.ids}"]
 cross_zone_load_balancing   = true
 idle_timeout                = 400
 connection_draining         = true
 connection_draining_timeout = 400
}

