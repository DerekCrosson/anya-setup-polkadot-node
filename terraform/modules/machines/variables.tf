variable "availability_zone" {
  default = "eu-west-1c"
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
