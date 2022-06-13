variable "security_group_name" {
  default = "polkadot"
}

variable "cidr_block" {
  default = "172.26.0.0/16"
}

variable "collator_node_ports" {
  default = ["9933", "9944"]
}

variable "rpc_node_ports" {
  default = ["80", "443"]
}
