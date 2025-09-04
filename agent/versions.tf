terraform {
  required_version = ">= 1.14.8"
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = ">= 4.29.0"
    }
    minio = {
      source  = "aminueza/minio"
      version = ">= 3.28.1"
    }
    n8n = {
      source  = "pinotelio/n8n"
      version = ">= 0.1.2"
    }
    http = {
      source  = "hashicorp/http"
      version = ">= 3.5.0"
    }
    terracurl = {
      source  = "devops-rob/terracurl"
      version = ">= 2.2.0"
    }
  }
}