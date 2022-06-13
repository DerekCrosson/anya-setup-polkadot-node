resource "aws_security_group" "polkadot_all_nodes" {
  name = var.security_group_name
}

resource "aws_security_group_rule" "all_nodes_rule" {
  type            = "ingress"
  from_port       = 30333
  to_port         = 30334
  protocol        = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.polkadot_all_nodes.id}"
}

resource "aws_security_group" "polkadot_collator_nodes" {
  name = var.security_group_name
}

resource "aws_security_group_rule" "collator_nodes_rule" {
  for_each = toset(var.collator_node_ports)
    type            = "ingress"
    from_port       = each.key
    to_port         = each.key
    protocol        = "tcp"
    cidr_blocks = ["${ var.cidr_block }"]

  security_group_id = "${aws_security_group.polkadot_collator_nodes.id}"
}

resource "aws_security_group" "polkadot_rpc_nodes" {
  name = var.security_group_name
}

resource "aws_security_group_rule" "rpc_nodes_rule" {
  for_each = toset(var.rpc_node_ports)
    type            = "egress"
    from_port       = each.key
    to_port         = each.key
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.polkadot_rpc_nodes.id}"
}
