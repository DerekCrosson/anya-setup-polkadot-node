data "aws_ami" "polkadot_image" {
  most_recent = true
  owners = ["self"]
  filter {                       
    name = "name"     
    values = ["ami-polkadot"]
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
