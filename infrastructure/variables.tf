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

# optional

variable "subdomain" {
  type        = string
  description = "Subdomain used as an `A` record for IP"
  default     = "docker"
}

variable "server_type" {
  type        = string
  description = "Server type used for docker builder"
  default     = "cpx31"
}
