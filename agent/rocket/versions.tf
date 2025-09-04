terraform {
  required_providers {
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