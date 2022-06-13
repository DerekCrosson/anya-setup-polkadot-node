locals {
  common_tags = {
    Name        = "${ var.tag_name }"
    Environment = "${ var.environment }"
  }
}

data "aws_ami" "polkadot_image" {
  most_recent = true
  owners      = ["self"]
  filter {
    name      = "name"
    values    = ["${ var.image_filter_name_value }"]
  }
}

resource "aws_instance" "polkadot_node" {
  for_each = {for k, v in var.nodes : k => v}
    ami                         = "${ data.aws_ami.polkadot_image.id }"
    instance_type               = "${ var.instance_size }"
    availability_zone           = "${ var.availability_zone }"
    associate_public_ip_address = true
    tags                        = each.value.tags
}

resource "aws_ebs_volume" "data_disk" {
  for_each            = var.volumes
    availability_zone = each.value.availability_zone
    size              = each.value.size
    type              = each.value.type
  
    tags = each.value.tags
}

resource "aws_volume_attachment" "volume_attachment" {
  for_each    = aws_ebs_volume.data_disk
    device_name     = contains(["polkadot-boot-node-primary",
                                "polkadot-boot-node-secondary",
                                "polkadot-collator-node",
                                "polkadot-rpc-node-1",
                                "polkadot-rpc-node-2"], each.key) ? "/dev/sdf" : "/dev/sdg"
    volume_id       = each.value.id
    instance_id     = aws_instance.polkadot_node[each.key].id
}
