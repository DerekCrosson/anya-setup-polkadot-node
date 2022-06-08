resource "aws_vpc" "polkadot" {
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name_tag
  }
}

resource "aws_subnet" "polkadot" {
  vpc_id = "${ aws_vpc.polkadot.id }"
  availability_zone = var.availability_zone
  
  map_public_ip_on_launch = true
}
