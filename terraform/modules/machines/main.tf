data "aws_ami" "polkadot_image" {
  most_recent = true
  owners      = ["self"]
  filter {
    name      = "name"
    values    = ["${ var.image_filter_name_value }"]
  }
}

resource "aws_instance" "polkadot_node" {
  ami                         = "${ data.aws_ami.polkadot_image.id }"
  instance_type               = "${ var.instance_size }"
  associate_public_ip_address = true
  tags                        = {
    Name = "${ var.tag_name }"
  }
}

resource "aws_ebs_volume" "data_disk" {
  availability_zone = "${ var.availability_zone }"
  size              = "${ var.disk_size }"
  type              = "${ var.disk_type }"
}

resource "aws_volume_attachment" "volume_attachment" {
  device_name     = "${ var.device_name }"
  volume_id       = aws_ebs_volume.data_disk.id
  instance_id     = aws_instance.polkadot_node.id
}
