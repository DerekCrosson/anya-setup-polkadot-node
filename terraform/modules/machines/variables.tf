variable "image_filter_name_value" {
  default = "ami-polkadot"
}

variable "instance_size" {
  default = "m4.large"
}

variable "availability_zone" {
  default = "eu-west-1c"
}

variable "disk_size" {
  default = 40
}

variable "disk_type" {
  default = "gp2"
}

variable "device_name" {
  default = "/dev/sdh"
}

variable "tag_name" {
  default = "polkadot"
}

variable "environment" {
  default = "production"
}

variable "subnet_id" {
  type = string
}

# variable "vpc_security_group_ids" {
#   type = list(string)
# }

variable "nodes" {
  type = map(object({
    tags              = map(string)
  }))
  default = {
    "polkadot-boot-node-primary" = {
      tags = {
        Name        = "primary-boot-node"
      }
    },
    "polkadot-boot-node-secondary" = {
      tags = {
        Name        = "secondary-boot-node"
      }
    },
    "polkadot-collator-node" = {
      tags = {
        Name        = "collator-node"
      }
    },
    "polkadot-rpc-node-1" = {
      tags = {
        Name        = "rpc-node-1"
      }
    },
    "polkadot-rpc-node-2" = {
      tags = {
        Name        = "rpc-node-2"
      }
    }
  }
}

variable "volumes" {
  default = {
    "polkadot-boot-node-primary" = {
      size              = "40"
      type              = "gp2"
      availability_zone = "eu-west-1c"
      tags = {
        Name            = "primary-boot-node"
      }
    },
    "polkadot-boot-node-secondary" = {
      size              = "40"
      type              = "gp2"
      availability_zone = "eu-west-1c"
      tags = {
        Name            = "secondary-boot-node"
      }
    },
    "polkadot-collator-node" = {
      size              = "100"
      type              = "gp2"
      availability_zone = "eu-west-1c"
      tags = {
        Name        = "collator-node"
      }
    },
    "polkadot-rpc-node-1" = {
      size              = "100"
      type              = "gp2"
      availability_zone = "eu-west-1c"
      tags = {
        Name        = "rpc-node-1"
      }
    },
    "polkadot-rpc-node-2" = {
      size              = "100"
      type              = "gp2"
      availability_zone = "eu-west-1c"
      tags = {
        Name        = "rpc-node-2"
      }
    }
  }
}
