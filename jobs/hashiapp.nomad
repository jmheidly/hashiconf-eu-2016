job "hashiapp" {
  datacenters = ["dc1"]
  type = "service"

  update {
    stagger = "5s"
    max_parallel = 1
  }

  group "hashiapp" {
    count = 3

    task "hashiapp" {
      driver = "exec"
      config {
        command = "hashiapp"
      }

      env {
        VAULT_TOKEN = "33e35fca-0644-ca67-5ce1-2dca18333b47"
        VAULT_ADDR = "http://vault.service.consul:8200"
        HASHIAPP_DB_HOST = "104.154.93.127:3306"
      }

      artifact {
        source = "https://storage.googleapis.com/evernew/v1.0.0/hashiapp"
        options {
          checksum = "sha256:ce68362c55554632b32b12301c97f21bbdbab081d5a5107fd3424b769ae5d648"
        }
      }

      resources {
        cpu = 500
        memory = 64
        network {
          mbits = 1
          port "http" {}
        }
      }

      service {
        name = "hashiapp"
        tags = ["urlprefix-hashiapp.com/"]
        port = "http"
        check {
          type = "http"
          name = "healthz"
          interval = "15s"
          timeout = "5s"
          path = "/healthz"
        }
      }
    }
  }
}
