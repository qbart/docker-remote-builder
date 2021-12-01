resource "hcloud_ssh_key" "my" {
  name       = "my"
  public_key = var.public_key
}
