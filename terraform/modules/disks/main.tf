resource "aws_ebs_volume" "data_disk" {
  availability_zone = "${ var.availability_zone }"
  size              = "${ var.disk_size }"
}

resource "aws_volume_attachment" "volume_attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.data_disk.id
}
