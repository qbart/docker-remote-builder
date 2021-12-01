terraform {
  required_version = "~> 1.0"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.32"
    }

    hetznerdns = {
      source  = "timohirt/hetznerdns"
      version = "~> 1.2"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

provider "hetznerdns" {
  apitoken = var.hcloud_dns_token
}

