packer {
  required_plugins {
    hcloud = {
      version = ">= 1.1.1"
      source  = "github.com/hetznercloud/hcloud"
    }
  }
}

variable "version" {
  default = "0.2.0"
}

source "hcloud" "client" {
  image       = "ubuntu-22.04"
  location    = "fsn1"
  server_type = "cx21"
  snapshot_labels = {
    snapshot = "docker"
    version  = var.version
  }
  snapshot_name = "docker-${var.version}"
  ssh_username  = "root"
}

build {
  sources = ["source.hcloud.client"]

  # system

  provisioner "shell" {
    script = "./setup-docker.sh"
  }
}
