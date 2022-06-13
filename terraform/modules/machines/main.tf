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

resource "aws_acm_certificate" "ssl_certificate" {
  domain_name       = "derekcrosson.africa"
  validation_method = "DNS"

  tags = {
    Environment = "${ var.environment }"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_volume_attachment" "volume_attachment" {
  for_each    = aws_ebs_volume.data_disk
    device_name     = "${ var.device_name }"
    volume_id       = each.value.id
    instance_id     = aws_instance.polkadot_node[each.key].id
}

resource "aws_elb" "load_balancer" {
  name               = "polkadot-rpc-nodes-load-balancer"
  availability_zones = ["eu-west-1a", "eu-west-1c"]

  # access_logs {
  #   bucket        = "logs"
  #   bucket_prefix = "polkadot-rpc-nodes-load-balancer"
  #   interval      = 60
  # }

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port      = 8000
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = aws_acm_certificate.ssl_certificate.id #"arn:aws:iam::123456789012:server-certificate/certName"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "polkadot-rpc-nodes-load-balancer"
  }
}

resource "aws_elb_attachment" "load_balancer_attachment" {
  for_each = aws_ebs_volume.data_disk
    elb      = aws_elb.load_balancer.id
    instance = aws_instance.polkadot_node[each.key].id
}
