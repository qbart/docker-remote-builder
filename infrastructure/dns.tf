data "hetznerdns_zone" "domain" {
  name = var.domain
}

resource "hetznerdns_record" "builder" {
  zone_id = data.hetznerdns_zone.domain.id
  name    = var.subdomain
  value   = hcloud_server.builder.ipv4_address
  type    = "A"
  ttl     = 60
}
