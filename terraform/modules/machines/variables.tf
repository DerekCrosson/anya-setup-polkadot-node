variable "image_filter_name_value" {
  default = "ami-polkadot"
}

variable "instance_size" {
  default = "m4.large"
}

variable "tag_name" {
  default = "polkadot"
}

variable "subnet_id" {
  type = string
}

variable "vpc_security_group_ids" {
  type = list(string)
}
