output "ip" {
  description = "Instance public IP"
  value       = hcloud_server.builder.ipv4_address
}
