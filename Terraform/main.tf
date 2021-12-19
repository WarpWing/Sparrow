terraform {
  required_providers {
    lxd = {
      source = "terraform-lxd/lxd"
      version = "1.6.0"
    }
  }
}

provider "lxd" {
  generate_client_certificates = true
  accept_remote_certificate    = true
} 
resource "lxd_container" "anvil" {
  name      = "anvil"
  image     = "ubuntu:20.04"
  ephemeral = false
  profiles = ["default"]
  limits     = {
      "memory" = "2800MB"
      "cpu" = 2
  }
}

resource "lxd_container" "metal1" {
  name      = "metal1"
  image     = "ubuntu:20.04"
  ephemeral = false
  profiles = ["default"]
   limits     = {
      "memory" = "1800MB"
      "cpu" = 2
  }
}

resource "lxd_storage_pool" "bucket" {
  name = "bucket"
  driver = "zfs"
  config = {
    size   = "40GB"
  }
}

resource "lxd_volume" "forgechild" {
  name = "forgechild"
  pool = "${lxd_storage_pool.bucket.name}"
}


output "anvil-ip" {
  value = lxd_container.anvil.ip_address
}

output "metal1-ip" {
  value = lxd_container.metal1.ip_address
}