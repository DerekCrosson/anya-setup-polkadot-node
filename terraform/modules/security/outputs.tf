variable "vpc_id" {
  type = string
}

output "polkadot_rpc_nodes_security_group_id" {
  value = "${ aws_security_group.polkadot_rpc_nodes.id }"
}

output "polkadot_collator_nodes_security_group_id" {
  value = "${ aws_security_group.polkadot_collator_nodes.id }"
}

output "polkadot_all_nodes_security_group_id" {
  value = "${ aws_security_group.polkadot_all_nodes.id }"
}
