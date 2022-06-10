variable "availability_zone" {
  default = "eu-west-1c"
}

variable "disk_size" {
  default = 40
}

variable "disk_type" {
  default = "gp2"
}

variable "device_name" {
  default = "/dev/sdh"
}

variable "instance_id" {
  type = string
}
