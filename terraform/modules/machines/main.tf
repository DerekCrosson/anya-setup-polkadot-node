resource "aws_instance" "node" {
  ami                         = "${ data.aws_ami.packer_image.id }"
  instance_type               = "${ var.instance_size }"
  subnet_id                   = "${ aws_subnet.polkadot[0].id }"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${ aws_security_group.polkadot.id }"]
  tags                        = {
    Name = "${ var.tag_name }"
  }
}

resource "aws_ebs_volume" "data" {
  availability_zone = "${ var.availability_zone }"
  size              = "${ var.disk_size }"
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.data.id
  instance_id = aws_instance.node.id
}
