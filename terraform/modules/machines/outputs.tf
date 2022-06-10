output "node_id" {
  value = "${ aws_instance.polkadot_node.id }"
}

output "polkadot_image_id" {
  value = "${ data.aws_ami.polkadot_image.id }"
}
