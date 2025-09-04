terraform {
  required_providers {
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