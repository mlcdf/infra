terraform {
  cloud {
    organization = "mlcdf"

    workspaces {
      name = "prod"
    }
  }
}

variable "apikey" {
  description = "value"
  sensitive   = true
}

module "web-dns" {
  source = "./modules/web-dns"

  apikey = var.apikey

  ipv4 = "146.59.209.152"
  ipv6 = "2001:41d0:301::31"

  domain = "mlcdf.fr"
  record_names = [
    "www",
    "www.dev-www",
    "dev-www",
    "resume"
  ]
}
