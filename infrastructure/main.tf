data "cloudinit_config" "builder" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "init.yml"
    content_type = "text/cloud-config"
    content = templatefile("./cloudinit.yml", {
      username   = var.username
      public_key = var.public_key
    })
  }
}

data "hcloud_image" "builder" {
  with_selector = "snapshot=docker,version=0.2.0"
}

resource "hcloud_server" "builder" {
  name               = "builder"
  server_type        = var.server_type
  image              = data.hcloud_image.builder.id
  location           = "nbg1"
  placement_group_id = hcloud_placement_group.default.id

  ssh_keys = [
    hcloud_ssh_key.my.id
  ]

  user_data = data.cloudinit_config.builder.rendered
}

resource "hcloud_placement_group" "default" {
  name = "default"
  type = "spread"
}

resource "hcloud_server_network" "builder" {
  server_id = hcloud_server.builder.id
  subnet_id = hcloud_network_subnet.main.id
  ip        = "10.0.1.2"
}
