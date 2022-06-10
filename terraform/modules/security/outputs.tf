variable "vpc_id" {
  type = string
}

output "security_group_id" {
  value = "${ aws_security_group.polkadot.id }"
}
