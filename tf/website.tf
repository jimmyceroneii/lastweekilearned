terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = "placeholder"
}

resource "digitalocean_droplet" "lastweek" {
  name = "last-week"
  image = "ubuntu-23-04-x64"
  size = "s-1vcpu-512mb-10gb"
  backups = false
  monitoring = true
  private_networking = true

  tags = ["lastweek"]

  timeouts {
    create = "30m"
    delete = "30m"
  }
}
