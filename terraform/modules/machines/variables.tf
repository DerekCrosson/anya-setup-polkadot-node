variable "image_filter_name_value" {
  default = "ami-polkadot"
}

variable "instance_size" {
  default = "m4.large"
}

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

variable "tag_name" {
  default = "polkadot"
}

variable "subnet_id" {
  type = string
}

# variable "vpc_security_group_ids" {
#   type = list(string)
# }
