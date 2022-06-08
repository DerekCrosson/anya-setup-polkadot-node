resource "aws_security_group" "polkadot" {
  name = var.security_group_name
  vpc_id = "${ aws_vpc.polkadot.id }"
}
