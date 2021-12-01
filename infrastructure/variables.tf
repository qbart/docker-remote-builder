variable "public_key" {
  type        = string
  description = "Public key"
}

variable "username" {
  type        = string
  description = "User name for ssh auth"
}

variable "domain" {
  type        = string
  description = "Domain name (docker host will become <subdomain>.<domain>)"
}

variable "hcloud_token" {
  type        = string
  description = "Hetzner Cloud token"
}

variable "hcloud_dns_token" {
  type        = string
  description = "Hetzner Cloud DNS api token"
}

# optional

variable "subdomain" {
  type        = string
  description = "Subdomain used as an `A` record for IP"
  default     = "docker"
}

variable "server_type" {
  type        = string
  description = "Server type used for docker builder"
  default     = "cpx21"
}

