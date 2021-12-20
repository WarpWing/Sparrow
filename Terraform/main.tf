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

resource "lxd_profile" "iceberg" {
  name = "iceberg"
  config = {
      "limits.memory" = "1800MB"
      "limits.cpu" = 2
      "user.access_interface" = "eth0"
  }
    device {
      name = "shared"
      type = "disk"

      properties = {
        source = "/tmp"
        path   = "/tmp"
      }
    }

    device {
      type = "disk"
      name = "root"

      properties = {
        pool = "default"
        path = "/"
      }
  }  
}

resource "lxd_container" "glacier0" {
  name      = "glacier0"
  image     = "ubuntu:20.04"
  ephemeral = false
  profiles = ["default", "${lxd_profile.iceberg.name}"]
}

output "glacier0" {
  value = lxd_container.glacier0.ip_address
}

resource "lxd_container" "glacier1" {
  name      = "glacier1"
  image     = "ubuntu:20.04"
  ephemeral = false
  profiles = ["default", "${lxd_profile.iceberg.name}"]
}

output "glacier1" {
  value = lxd_container.glacier1.ip_address
} 

resource "lxd_container" "glacier2" {
  name      = "glacier2"
  image     = "ubuntu:20.04"
  ephemeral = false
  profiles = ["default", "${lxd_profile.iceberg.name}"]
}

output "glacier2" {
  value = lxd_container.glacier2.ip_address
} 

resource "lxd_container" "glacier3" {
  name      = "glacier"
  image     = "ubuntu:20.04"
  ephemeral = false
  profiles = ["default", "${lxd_profile.iceberg.name}"]
}

output "glacier3" {
  value = lxd_container.glacier3.ip_address
}