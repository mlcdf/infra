terraform {
  required_providers {
    gandi = {
      source  = "go-gandi/gandi"
      version = ">= 2.1.0"
    }
  }
}

variable "apikey" {
  description = "A GANDI API key"
  sensitive   = true
}

variable "ipv4" {
  description = "IPv4"
}

variable "ipv6" {
  description = "IPv6"
}

variable "domain" {
  description = "The FQDN of the domain"
}

variable "record_names" {
  description = "A list of records' name"
  type        = list(string)
}


provider "gandi" {
  key = var.apikey
}

resource "gandi_livedns_record" "A" {
  for_each = toset(var.record_names)

  zone = var.domain
  name = each.value
  type = "A"
  ttl  = 3600
  values = [
    "${var.ipv4}"
  ]
}

resource "gandi_livedns_record" "AAAA" {
  for_each = toset(var.record_names)

  zone = var.domain
  name = each.value
  type = "AAAA"
  ttl  = 3600
  values = [
    "${var.ipv6}"
  ]
}
