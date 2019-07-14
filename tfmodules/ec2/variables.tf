variable "region" {}
variable "env" {}
variable "ami_name" {}
variable "key_name" {}

variable "nombre" {
  type = "string"
  description = "nombre de la instancia" 
  default = "HolaNginx"
}
