job "hashiapp" {
  datacenters = ["dc1"]
  type = "service"

  update {
    stagger = "5s"
    max_parallel = 1
  }

  group "hashiapp" {
    count = 2

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
          checksum = "sha256:cfb1c651ec9088a690197bb0410ca1e55d9eae432769b6b70c08cfb4b7b758d9"
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
