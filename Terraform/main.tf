terraform {
  required_providers {
    lxd = {
      source = "terraform-lxd/lxd"
      version = "1.6.0"
    }
  }
}

resource "lxd_container" "anvil" {
  name      = "anvil"
  image     = "ubuntu:20.04"
  ephemeral = false

  config = {
    "boot.autostart" = true
  }

  limits = {
    cpu = 1
    memory = 2
  }
}