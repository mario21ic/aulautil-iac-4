# Write
resource "consul_keys" "write_web_sg_id" {
  key {
    path  = "aulautil/${terraform.workspace}/network/web_sg_id"
    value = "${module.web.sg_id}"
  }
}

# Read
data "consul_keys" "read_web_sg_id" {
  key {
    name = "web_sg_id"
    path = "aulautil/${terraform.workspace}/network/web_sg_id"

    #default = ""
  }
}

